# EXITNODE Website

## About

This is a jekyll static page.  Jekyll is a static site generator written in Ruby.  Jekyll is the static site generator chosen by github for github pages and thus we are beholden to it.

The site is live at www.exitnode.io

## Contributing

Jekyll is relatively simple to understand and doesn't require any coding knowledge or knowledge of ruby.  Most of the sites pages are written in Kramdown and rendered into HTML by Jekyll when the github pages flow kicks off after a new commit.

In order to contribute you will need to install ruby.  I recommend using rbenv over your local package manager as we will need to use a specific version of ruby to run the local version of this site.  RVM is also available as an alternative to rbenv, but we will use rbenv here.

1. Install rbenv, instructions can be found on github

	https://github.com/rbenv/rbenv
2. Install the version of ruby indicated in the .ruby-version file in this repo, `3.3.0`

	`rbenv install 3.3.0`
3. While in the directory for this project, set the local version to 3.3.0

	`rbenv local 3.3.0`
4. Install dependencies with Bundler

	`bundle install`
5. Run the jekyll development server

	`bundle exec jekyll s`

Once Jekyll is running you can make changes to the site and they will be reflected upon save on the address and port indicated in your terminal.
