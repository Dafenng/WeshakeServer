# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

WeshakeServer::Application.load_tasks

require './config/environment'
require 'csv'

namespace :import do
  task :photo_desc do
    CSV.foreach('./photo_desc.csv', :headers => true) do |row|
      aPhoto_url =  "/resource/shop_photo_new/#{row.to_hash['shopid']}/#{row.to_hash['photo_type']}/#{row.to_hash['shopid']}_#{row.to_hash['seq']}_320x320_rect.jpg"
      photo = ShopPhoto.find_by(photo_url: aPhoto_url)
      unless photo.nil?
        if row.to_hash['description'].nil? || row.to_hash['description'].eql?('')

        else
          photo.description = row.to_hash['description']
          photo.save
        end
      end
    end
  end

  task :shops do
    CSV.foreach('./shops.csv', :headers => true) do |row|
      shop = Shop.new(row.to_hash)
      lunch_budget_string = shop.lunch_budget.gsub(',', '')
      lunch_budget = lunch_budget_string[/(\d+)\D+(\d+)/, 1]
      if !lunch_budget.nil?
        shop.lunch_budget_average = (lunch_budget_string[/(\d+)\D+(\d+)/, 1].to_i + lunch_budget_string[/(\d+)\D+(\d+)/, 2].to_i + 1) / 2
      else
        lunch_budget = lunch_budget_string[/\d+/]
        if !lunch_budget.nil?
          shop.lunch_budget_average = lunch_budget.to_i
        else
          shop.lunch_budget_average = 0
        end
      end
      
      dinner_budget_string = shop.dinner_budget.gsub(',', '')
      dinner_budget = dinner_budget_string[/(\d+)\D+(\d+)/, 1]
      if !dinner_budget.nil?
        shop.dinner_budget_average = (dinner_budget_string[/(\d+)\D+(\d+)/, 1].to_i + dinner_budget_string[/(\d+)\D+(\d+)/, 2].to_i + 1) / 2
      else
        dinner_budget = dinner_budget_string[/\d+/]
        if !dinner_budget.nil?
          shop.dinner_budget_average = dinner_budget.to_i
        else
          shop.dinner_budget_average = 0
        end
      end
      shop.save
    end
  end

  task :shop_photos do
    Dir.chdir('./public/resource/shop_photo_new')
    Dir.glob('[0-9]*').each do | dir |
      Dir.chdir(dir)
      shop = Shop.find_by(extern_id: dir)
      
      Dir.glob('[a-z]*').each do | sub_dir |
        Dir.chdir(sub_dir)
        Dir.glob('*square.jpg').each do | square_photo |
          shop_photo = ShopPhoto.new
          shop_photo.photo_url = '/resource/shop_photo_new/'+ dir + '/' + sub_dir + '/' + square_photo
          shop_photo.shop_id = shop.id
          shop_photo.photo_type = sub_dir
          shop_photo.size_type = 'square'
          shop_photo.save
        end
        
        Dir.glob('*rect.jpg').each do | rect_photo |
          shop_photo = ShopPhoto.new
          shop_photo.photo_url = '/resource/shop_photo_new/'+ dir + '/' + sub_dir + '/' + rect_photo
          shop_photo.shop_id = shop.id
          shop_photo.photo_type = sub_dir
          shop_photo.size_type = 'rect'
          shop_photo.save
        end
        Dir.chdir('../')
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
