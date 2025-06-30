---
permalink: /
layout: archive
excerpt: "About Me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
Hello! 

<br>

I am an Assistant Professor at the IIES at Stockholm University and an Associate at Opportunity Insights at Harvard University. I received my PhD in Political Economy and Government in 2025 from Harvard. 

<br>

In my research, I primarily explore how social capital shapes economic outcomes, for instance by influencing where people live and how much they earn. In a second strand of work, I investigate the causes and consequences of political preferences and polarization. 

<br>


Before graduate school, I worked at Opportunity Insights and earned a MSc in Economics from the University of Mannheim, and a BSc in Economics from Humboldt University of Berlin.  

<br>

Job Market Paper
------
{% for post in site.jmp reversed %}
  {% include archive-single.html %}
{% endfor %}

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
