---
permalink: /
layout: archive
excerpt: "About Me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---
I'm a Member of the Technical Staff at OpenAI, working as a data scientist on the economic research team.

Before that, I worked at Meta's Social Capital Lab, studying the connections between social ties, places, and economic opportunity.

I received my PhD in Economics from Harvard University in 2024.

As an undergraduate, I studied economics and computer science at Columbia University.

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
