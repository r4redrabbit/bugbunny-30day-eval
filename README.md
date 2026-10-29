# BugBunny.ai — 30-Day Live Evaluation

Static site (GitHub Pages + Jekyll `jekyll-theme-hacker`) that publishes a daily
ROI log for a 30-day evaluation of BugBunny.ai.

## Layout

```
_config.yml            # site config, theme, plugins
index.md               # landing page + auto-generated post list
_layouts/post.html     # post layout (inherits the theme's default)
_posts/                # one Markdown file per day
publish.sh             # creates / publishes a daily post
```

## One-time setup

```bash
cd ~/bugbunny-30day-eval
git init -b main
git add -A
git commit -m "Initial commit: GitHub Pages setup"

# create the empty repo on GitHub, then:
git remote add origin git@github.com:<you>/<repo>.git
git push -u origin main
```

Then in the repo: **Settings → Pages → Build and deployment →
Source: Deploy from a branch → Branch: `main` / `/ (root)` → Save.**

Your site appears at `https://<you>.github.io/<repo>/` within a minute or two.

## Daily workflow

```bash
./publish.sh 1 "Testing SSRF on Example.com"   # creates _posts/YYYY-MM-DD-day-01-....md
$EDITOR _posts/YYYY-MM-DD-day-01-testing-ssrf-on-example-com.md
./publish.sh 1 "Testing SSRF on Example.com"   # commits + pushes -> live
```

Re-running with an existing file idempotently stages, commits and pushes it.
`index.md` and `/feed.xml` update automatically.

## Local preview (optional)

GitHub Pages builds with the `github-pages` gem. If Ruby is available:

```bash
bundle install
bundle exec jekyll serve
```

On Termux this is heavy; it is fine to skip and rely on GitHub's build.

## Alternative: GitHub Actions deploy

If you prefer Actions over branch builds, add
`.github/workflows/pages.yml` using `actions/jekyll-build-pages@v1` +
`actions/deploy-pages@v4`, and set Pages → Source to **GitHub Actions**.
Branch deploy is simpler for a single-author blog, so it is not included here.

## Notes

- `theme: jekyll-theme-hacker` is in the GitHub Pages whitelist, so no Gemfile
  is required for the hosted build.
- `jekyll-feed` is also whitelisted and generates `/feed.xml`.
- Only publish results for targets you are authorised to test.
- If you accept credits or perks from a vendor, say so in the post.
