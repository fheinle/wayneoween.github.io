---
layout: page
title: Aufenthaltsort
current_location: "Waterdeep"
background: '/img/map.jpg'
---

Aktuelle Position: {% include glossary_link.html title=page.current_location %}
<div class='location-map' up-data="{{page.current_location | jsonify | escape}}"></div>
## Bereits besuchte Orte
