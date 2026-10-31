#!/usr/bin/env ruby
# Check the built site without fetching external URLs.
require "nokogiri"
require "pathname"
require "set"
require "uri"
require "yaml"

class SiteVerifier
  def initialize(destination)
    @destination = Pathname(destination).expand_path
    config = YAML.safe_load(File.read(File.expand_path("../_config.yml", __dir__)), aliases: true)
    @site_url = URI.parse(config.fetch("url"))
    @hosts = Set.new([@site_url.hostname, "localhost", "127.0.0.1", "::1"])
    @baseurl = config.fetch("baseurl", "").to_s.sub(%r{/$}, "")
    @documents = {}
    @errors = []
  end

  def run
    unless @destination.directory?
      warn "Build directory not found: #{@destination}"
      return false
    end

    html_files = @destination.glob("**/*.html")
    homepage = @destination.join("index.html")
    if homepage.file?
      check_homepage(document(homepage))
    else
      error(homepage, "homepage is missing")
    end
    html_files.each { |path| check_html(path, path == homepage) }
    @destination.glob("**/*.css").each { |path| check_css(path) }
    check_tooling

    if @errors.empty?
      puts "Verified #{html_files.length} HTML pages and local assets in #{@destination}."
      true
    else
      warn @errors.uniq.join("\n")
      warn "Verification failed (#{@errors.uniq.length} issues)."
      false
    end
  end

  private

  def document(path)
    @documents[path.to_s] ||= Nokogiri::HTML(File.read(path))
  end

  def error(path, message)
    @errors << "#{path.relative_path_from(@destination)}: #{message}"
  end

  def check_homepage(doc)
    checks = {
      "page title" => !doc.at_css("title")&.text.to_s.strip.empty?,
      "main content" => !doc.at_css("main, [role='main']")&.text.to_s.strip.empty?,
      "stylesheet" => doc.at_css("link[rel~='stylesheet'][href]"),
      "JavaScript bundle" => doc.at_css("script[src]"),
      "profile image" => doc.at_css(".author__avatar img[src]")
    }
    checks.each { |name, present| error(@destination.join("index.html"), "missing #{name}") unless present }
  end

  def check_html(path, homepage)
    doc = document(path)
    error(path, "unexpanded Liquid template") if File.read(path).match?(/\{[{%]/)
    doc.css("[href], [src], [poster]").each do |node|
      %w[href src poster].each do |attribute|
        next unless node.key?(attribute)
        value = node[attribute].strip
        if value.empty?
          error(path, "empty #{node.name}[#{attribute}]")
        elsif value == "#"
          disabled = node["class"].to_s.split.include?("disabled") || node["aria-disabled"] == "true"
          error(path, "placeholder #{node.name}[#{attribute}]") unless disabled && !homepage
        else
          check_reference(path, value, attribute == "href")
        end
      end
    end
    return unless homepage

    doc.css("a[href]").each do |link|
      label = [link.text, link["aria-label"], link["title"], *link.css("img[alt]").map { |img| img["alt"] }]
      error(path, "link has no accessible text: #{link['href']}") if label.all? { |text| text.to_s.strip.empty? }
    end
  end

  def check_css(path)
    css = File.read(path).gsub(%r{/\*.*?\*/}m, "")
    css.scan(/url\(\s*(?:"([^"]*)"|'([^']*)'|([^)]*?))\s*\)/i).each do |captures|
      value = captures.compact.first.to_s.strip
      next if value.start_with?("#")
      value.empty? ? error(path, "empty CSS URL") : check_reference(path, value, false)
    end
    css.scan(/@import\s+["']([^"']+)["']/i).each do |captures|
      check_reference(path, captures.first, false)
    end
  end

  def check_reference(source, value, check_anchor)
    # Preserve existing escapes and encode spaces or Unicode before URI parsing.
    encoded = value.gsub(/[^\x21-\x7e]/) { |character| character.bytes.map { |byte| "%%%02X" % byte }.join }
    uri = URI.parse(encoded)
    return if uri.scheme && !%w[http https].include?(uri.scheme.downcase)
    return if uri.host && !@hosts.include?(uri.hostname)

    source_url = "/" + source.relative_path_from(@destination).to_s
    base = @site_url.dup
    base.path = @baseurl + source_url
    base.query = base.fragment = nil
    target = URI.join(base.to_s, encoded)
    path = URI::DEFAULT_PARSER.unescape(target.path)
    if !@baseurl.empty? && (path == @baseurl || path.start_with?(@baseurl + "/"))
      path = path.delete_prefix(@baseurl)
    end
    file = find_file(path)
    unless file
      error(source, "missing local target: #{value}")
      return
    end
    return unless check_anchor && file.extname.downcase == ".html" && target.fragment

    fragment = URI::DEFAULT_PARSER.unescape(target.fragment).split(":~:text=", 2).first.to_s
    return if fragment.empty?
    found = document(file).css("[id], a[name]").any? { |node| node["id"] == fragment || node["name"] == fragment }
    error(source, "missing anchor ##{fragment}: #{value}") unless found
  rescue URI::InvalidURIError => exception
    error(source, "invalid URL #{value.inspect}: #{exception.message}")
  end

  def find_file(url_path)
    path = @destination.join(url_path.sub(%r{\A/+}, "")).cleanpath
    return unless path.to_s.start_with?(@destination.to_s + "/") || path == @destination
    candidates = [path, path.join("index.html")]
    candidates << Pathname(path.to_s + ".html") if path.extname.empty?
    candidates.find(&:file?)
  end

  def check_tooling
    directories = %w[bin script vendor node_modules .bundle]
    files = %w[Gemfile Gemfile.lock README.md package.json package-lock.json pnpm-lock.yaml yarn.lock bun.lock bun.lockb]
    directories.each do |name|
      path = @destination.join(name)
      error(path, "development tooling was published") if path.exist?
    end
    @destination.glob("**/*", File::FNM_DOTMATCH).each do |path|
      next if [".", ".."].include?(path.basename.to_s)
      relative = path.relative_path_from(@destination)
      next if directories.include?(relative.each_filename.first)
      if files.include?(path.basename.to_s)
        error(path, "development tooling was published")
      end
    end
  end
end

exit(SiteVerifier.new(ARGV.fetch(0, "_site")).run ? 0 : 1)
