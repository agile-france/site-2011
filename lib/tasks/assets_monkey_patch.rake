# XXX this sucks !!
# http://stackoverflow.com/questions/7430578/how-to-universally-skip-database-touches-when-precompiling-assets-on-heroku
#
# monkey patch from https://gist.github.com/1239732
#
# just to compile a few assets, routes, then database are required ...
# non sense!
#
namespace :assets do
  # Prepend the assets:hack task to assets:precompile.
  task :precompile => :hack
  # This task will be called before assets:precompile to optimize the
  # compilation, i.e. to prevent any DB calls.
  task :hack do
    # Without this assets:precompile will call itself again with this var set.
    # This basically speeds things up.
    ENV['RAILS_GROUPS'] = 'assets'
    # Devise uses this flag to prevent connecting to the db.
    ENV['RAILS_ASSETS_PRECOMPILE'] = 'true'
    # Prevent mongoid from loading
    def Mongoid.load!(*args)
      true
    end
  end
end