# source tree is read only on heroku (http://blog.heroku.com/archives/2009/8/18/heroku_sass/)
# there are options
# - add static middleware to rw directory (http://blog.siyelo.com/the-easiest-way-to-make-sasscompass-work-on-h)
# that is retained option, see config.ru
# - commit generated css (git pre-commit hook, client pre-push does not exist yet I believe)
# like it tough it does cripple the source tree with duplication
# there is something missing with deploying on heroku, build|generate as post push
Sass::Plugin.options[:css_location] = 'tmp/stylesheets'