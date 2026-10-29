---
layout: default
title: "30-Day Live Evaluation"
---

# BugBunny.ai: 30-Day Live Evaluation

Welcome to my live tracking hub. Over the next month I am running a data-driven
ROI analysis of BugBunny's automated bug bounty platform.

**Tracked metrics:** audit cost vs. bounty ROI, false-positive ratio, and
number of validated (proof-first) PoCs.

> Scope note: every target I test is one I am authorised to test. This log
> covers tooling, methodology and economics — not other people's systems.

## Daily log

{% assign posts = site.posts | sort: "date" %}
{% if posts.size == 0 %}
_First entry coming soon._
{% else %}
{% for post in posts %}
- [{{ post.title }}]({{ post.url }}) — <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%Y-%m-%d" }}</time>
{% endfor %}
{% endif %}

## Follow along

- RSS: [feed.xml]({{ "/feed.xml" | relative_url }})
