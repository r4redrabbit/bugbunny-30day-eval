# BugBunny.ai: 30-Day Evaluation

Daily log of a 30-day ROI test of BugBunny.ai, built with Jekyll and published
on GitHub Pages.

## Structure

```
_config.yml      site config
index.html       landing page + post list
_layouts/        default and post templates
_posts/          one file per day
publish.sh       create and publish a daily post
```

## Writing an entry

```bash
./publish.sh 1 "Testing SSRF on Example.com"
$EDITOR _posts/2026-11-01-day-01-testing-ssrf-on-example-com.md
./publish.sh 1 "Testing SSRF on Example.com"
```

The first run creates the file; the second commits and pushes it. The landing
page and `/feed.xml` update on their own.

## Rules

- Only test targets I'm authorised to test.
- Disclose any credits or perks from the vendor.
