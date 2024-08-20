---
permalink: /
layout: archive
excerpt: "About Me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
I'm a Postdoctoral Research Scientist at Meta.

At Meta, I work with the Social Capital Lab, studying the connections between social ties, places, and economic opportunity.

I received my PhD in Economics in 2024 from Harvard University, where I was advised by Raj Chetty, Ed Glaeser, and Jesse Shapiro.

Before that, I studied at Columbia University, where I received a BA in Computer Science and Economics.

<br>

Working Papers
------
{% for post in site.wps reversed %}
  {% include archive-single.html %}
{% endfor %}

Published Research
------
{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
<br>
