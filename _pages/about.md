---
permalink: /
layout: archive
excerpt: "About Me"
author_profile: true
visual_style: warm-editorial
redirect_from: 
  - /about/
  - /about.html
---
I’m a Member of the Technical Staff at OpenAI, where I work on the Economic Research team.

In my research, I use economics to learn about AI (and vice versa).

Previously, I worked at Meta's Social Capital Lab, studying social ties, places, and economic opportunity.

I received my PhD in economics from Harvard University and my bachelor’s degree in economics and computer science from Columbia University.

Working Papers
------
{% for post in site.wps reversed %}
  {% include archive-single-editorial.html %}
{% endfor %}

Published Research
------
{% for post in site.publications reversed %}
  {% include archive-single-editorial.html %}
{% endfor %}
