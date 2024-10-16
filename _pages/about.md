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

I am a PhD Candidate in Political Economy and Government at Harvard, and a research affiliate at Opportunity Insights and the Institute for Quantitative Social Science. 

<br>

In my research, I primarily explore how social capital shapes economic outcomes, for instance by influencing where people live and how much they earn. In a second strand of work, I investigate the causes and consequences of political preferences and polarization. 

<br>


Before graduate school, I worked at Opportunity Insights and earned a MSc in Economics from the University of Mannheim, and a BSc in Economics from Humboldt University of Berlin.  

<br>

I am currently on the 2024-2025 economics job market.

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
