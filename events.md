---
title: /events
layout: default
permalink: /events
---

{% assign recurrence_cutoff = site.time | date: "%s" | plus: 3024000 | date: "%Y-%m-%d" %}
{% ical url: https://exitnode.io/assets/cal/discord_events.ics reverse: false only_future: true recurring_end_date: recurrence_cutoff %}
  <span style='font-family:retro;font-size:1em !important;vertical-align:bottom' markdown='1'>[{{ event.summary }}]({{ event.location }})</span> | {{ event.start_time | date: "%m-%d-%Y at%l:%M %p" }}
  {{ event.simple_html_description }}
{% endical %}