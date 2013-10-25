# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

WeshakeServer::Application.load_tasks

require './config/environment'
require 'csv'

namespace :import do
  task :shops do
    CSV.foreach('./shops.csv', :headers => true) do |row|
      Shop.create!(row.to_hash)
    end
  end

  task :rating do
    i = 1
    while i < 7975 do
      shop = Shop.find(i)
      shop.rating=0
      shop.save
      i = i + 1
    end
  end

  task :cuisine do
    all_cui = []
    Shop.all.each do |shop|
      unless all_cui.include?(shop.cuisine_type)
        all_cui << shop.cuisine_type
      end
    end

    puts all_cui
  end

  task :cost do
    Shop.all.each do |shop|
      shop.cost = shop.budget[/\d+/]
      shop.save
    end
  end
end
