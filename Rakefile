# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

WeshakeServer::Application.load_tasks

require './config/environment'
require 'csv'

namespace :import do
  task :shops do
    CSV.foreach('./shops.csv', :headers => true) do |row|
      shop = Shop.new(row.to_hash)
      shop.rating = 0
      shop.save
    end
  end

  task :shop_photo do
    Dir.chdir('./public/resource/shop_photo')
    Dir.glob('000*').each do | dir |
      Dir.chdir('./'+dir)
      shop = Shop.find_by(extern_id: dir.to_i)
      unless shop.nil?
        Dir.glob('*.jpg').each do | jpg |
          shop_photo = ShopPhoto.new
          shop_photo.photo_url = '/resource/shop_photo/'+ dir + '/' + jpg
          shop_photo.shop_id = shop.id
          shop_photo.num_id = jpg[/[\d_]+/]
          shop_photo.save
        end
      end
      Dir.chdir('../')
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

  task :photo_count do
    count = 0
    Shop.all.each do |shop|
      if shop.shop_photos.count == 0
        count = count + 1
      end
    end
    puts count
  end
end
