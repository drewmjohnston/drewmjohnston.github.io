---
permalink: /
layout: archive
excerpt: "About Me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
Hello! I am a PhD candidate in Political Economy and Government at Harvard. In one branch of my work, I study issues related to social networks, inequality, and migration. In a second branch, I do research related to political preferences and polarization.

I am affiliated with Opportunity Insights and the Institute for Quantitative Social Science.

Before graduate school, I earned a MSc in Economics from the University of Mannheim, and a BSc in Economics from Humboldt University of Berlin.  

In between, I was a pre-doctoral fellow at Stanford and Harvard working for professors Raj Chetty, John Friedman and Nathan Hendren.

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
