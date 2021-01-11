---
permalink: /
layout: archive
title: "Drew Johnston"
excerpt: "About Me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
I'm a Ph.D student in Harvard's Economics Department, where I spend most of my time thinking about social influence, cities, and computers. 

Before that, I was at Columbia, where I earned a BA in Computer Science and Economics. In between, I did research at NYU Stern and Facebook.

Working Papers
======
{% include base_path %}
{% for post in site.wps reversed %}
  {% include archive-single.html %}
{% endfor %}

Early-Stage Work
======
{% for post in site.projects reversed %}
  {% include archive-single.html %}
{% endfor %}

Published Research
======
{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}