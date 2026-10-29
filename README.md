# BugBunny.ai — 30-Day Evaluation

Static site (GitHub Pages + Jekyll, custom dark layout) that publishes a daily
ROI log for a 30-day evaluation of BugBunny.ai.

## Layout

```
_config.yml            # site config, plugins
index.html             # landing page + auto-generated post list
_layouts/default.html  # page shell (head, nav, footer)
_layouts/post.html     # post layout (inherits default)
_posts/                # one Markdown file per day
publish.sh             # creates / publishes a daily post
```

## Daily workflow

```bash
./publish.sh 1 "Testing SSRF on Example.com"   # creates _posts/YYYY-MM-DD-day-01-....md
$EDITOR _posts/YYYY-MM-DD-day-01-testing-ssrf-on-example-com.md
./publish.sh 1 "Testing SSRF on Example.com"   # commits + pushes -> live
```

Re-running with an existing file idempotently stages, commits and pushes it.
The landing page and `/feed.xml` update automatically.

## Local preview (optional)

GitHub Pages builds with the `github-pages` gem. If Ruby is available:

```bash
bundle install
bundle exec jekyll serve
```

On Termux this is heavy; it is fine to skip and rely on GitHub's build.

## Notes

- No Gemfile is required for the hosted build: the layout ships its own CSS and
  `jekyll-feed` is whitelisted on GitHub Pages (it generates `/feed.xml`).
- Only publish results for targets you are authorised to test.
- If you accept credits or perks from a vendor, say so in the post.
