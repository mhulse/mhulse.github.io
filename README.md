# [mky.io](http://mky.io)

[GMO](http://en.wikipedia.org/wiki/Genetically_modified_organism)-, [gluten](http://en.wikipedia.org/wiki/Gluten)- and [Bootstrap](http://getbootstrap.com/)-free. :)

---

### Local testing:

```bash
$ bundle exec jekyll serve --watch --trace --config _config.yml,_config_local.yml
```

### Installation notes:

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

#### Links:

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


---

Starting a new Jekyll project.

I've setup a `master` and `source` branch; the former is where the `_site` files get copied to via a rake task.

In the `source` branch, create a Gemfile and add:

```
source 'https://rubygems.org'

gem 'jekyll'
gem 'rake'
```

Install Bundler:

```bash
gem install bundler
```

Install missing gems:

```bash
$ bundle install
```

Execute jekyll and serve:

```bash
$ bundle exec jekyll serve -w
```

**Note:** You don't need `.nojekyll` if source files live in `source` branch.

To update Jekyll, run:

```bash
$ bundle update jekyll
```

... or, update everything:

```bash
$ bundle update
```

Run your site using:

```bash
$ bundle exec jekyll serve -w
```

Drafts:

```bash
$ bundle exec jekyll serve -w --drafts
```

Now, view your locally-hosted site at http://localhost:4000.

**Note:** What is `bundle exec` anyway?

> It executes the script using the gems specified in the script's `Gemfile` rather than the system-wide `Gemfile`.

&mdash; [What does bundle exec rake mean?](http://stackoverflow.com/a/16218854/922323)

---

Generating Pygment test files:

```bash
# Create a test file in desired location with code you want to highlight.
# I'm using `virtualenvwrapper` with `pygments`, so:
$ workon jekyll_pygments
# Creates `test.html`, with line numbers:
$ pygmentize -f html -O style=monokai,linenos=1 -l css test.css > test.html
# No line numbers:
$ pygmentize -f html -O style=monokai -l css test.css > test.html
```

---

Copyright &copy; [Micky Hulse](http://mky.io) 2013-2014. **All rights reserved.**

Unauthorized use and/or duplication of this material, without express and written permission from the owner, is strictly prohibited.

<img width="20" height="20" align="absmiddle" src="https://github.global.ssl.fastly.net/images/icons/emoji/octocat.png" alt=":octocat:" title=":octocat:" class="emoji">
