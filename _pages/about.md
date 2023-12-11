---
permalink: /
layout: archive
excerpt: "About Me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
I'm a PhD candidate in Economics at Harvard, where I think about cities, the social world, and the interactions between them. 

At Harvard, I am affiliated with Opportunity Insights, the Institute for Quantitative Social Science, and the Davis Center

Before graduate school, I studied at Columbia, where I earned a BA in Computer Science and Economics. 

In between, I did research at NYU Stern and Facebook.

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
