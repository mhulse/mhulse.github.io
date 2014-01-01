---
layout: post
title:  "Installing Jekyll"
date:   2013-12-22 00:02:22
categories: [code]
tags: [jekyll, github]
---

First, get Ruby and `rvm` installed/updated:

* [Ruby tips](https://github.com/registerguard/registerguard.github.com/wiki/Ruby-tips)

Now, head on over to the installation instructions.

Here's [the Jekyll docs](http://jekyllrb.com/docs/installation/) and here's the [GitHub instructions](https://help.github.com/articles/using-jekyll-with-pages#installing-jekyll).

Make sure Xcode components are up-to-date ... Open Xcode and install/upgrade anything found here: <kbd>Preferences</kbd> → <kbd>Downloads</kbd> → <kbd>Components</kbd>

Now go to `terminal.app` and install `bundler`:

```bash
$ gem install bundler
```

Go to your repo and create a file named `Gemfile` (no extension); put this inside:

```text
source 'https://rubygems.org'
gem 'github-pages'
```

Next:

```bash
$ cd repo/
$ bundle install
```

Run Jekyll:

```bash
$ bundle exec jekyll serve
```

To update Jekyll, run:

```bash
$ cd repo/
$ bundle update github-pages
```

Run your site using:

```bash
$ jekyll serve -w
```

Drafts:

```bash
$ jekyll serve -w --drafts
```

---

## Links:

* [Jekyll](http://jekyllrb.com/)
* [Jekyll sites](https://github.com/jekyll/jekyll/wiki/Sites)
* [Jekyll From Scratch - Getting Started](http://pixelcog.com/blog/2013/jekyll-from-scratch-introduction/)
* [Using Jekyll and GitHub Pages for Our Site](http://developmentseed.org/blog/2011/09/09/jekyll-github-pages/)
* [Jekyll tag cloud](http://vvv.tobiassjosten.net/jekyll/jekyll-tag-cloud/)
* [Liquid Templating](http://docs.shopify.com/themes/liquid-basics)
* [Liquid: Tags](http://docs.shopify.com/themes/liquid-basics/logic)
* [Liquid: Filters](http://docs.shopify.com/themes/liquid-basics/output)
* [Simple Jekyll Searching](https://alexpearce.me/2012/04/simple-jekyll-searching/)
* [Simple Category Pages with vanilla Jekyll](http://primalivet.com/2013/11/simple-category-pages-with-vanilla-jekyll/)
