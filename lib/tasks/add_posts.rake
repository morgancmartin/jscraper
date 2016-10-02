namespace :add_posts do
  task :scrape => [:environment] do
    # doing stuff with your Rails app like
    # messing with models
    s = ScraperRunner.new
    s.run
  end
end
