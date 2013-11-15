module Api
  module V1
    class ShopsController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access
      respond_to :json
      
      def index
        radius = params[:radius].to_f
        latitude = params[:latitude].to_f
        longitude = params[:longitude].to_f
        start = params[:start].to_i
        count = params[:count].to_i

        process = params[:process]
        if process.eql?('suggest')
          region = params[:region]
          suggest(region, latitude, longitude, radius)
        elsif process.eql?('around')
          around(latitude, longitude, start, count)
        elsif process.eql?('search')
          region = params[:region]
          area = params[:area]
          district = params[:district]
          genre = params[:genre]
          cuisine = params[:cuisine]
          period = params[:period]
          budget = params[:budget]

          search(latitude, longitude, region, area, district, genre, cuisine, period, budget, start, count)
        elsif process.eql?('favor')
          user_id = params[:user_id].to_i
          favor(user_id, start, count)
        end
      end

      def show
        @shop = Shop.find(params[:id])
        render json: @shop
      end

      def create
        respond_with Shop.create(params[:shop])
      end

      def update
        respond_with Shop.update(params[:id], params[:shop])
      end

      def destroy
        respond_with Shop.destroy(params[:id])
      end

      private

      def suggest(region, latitude, longitude, radius)
        if not region.nil?
          @shops = Shop.where(region: region).limit(100)
        else
          @shops = Shop.near([latitude, longitude], radius).limit(100)
        end
        @shop = @shops.sample

        if not @shop.nil?
          render json: @shop, meta: { status: :ok, total: @shops.count }, meta_key: 'result'
        else
          render json: [], meta: { status: :ok, total: 0 }, meta_key: 'result'
        end
      end

      def around(latitude, longitude, start, count)
        @shops = Shop.near([latitude, longitude], 5).limit(start + count)
        @shops = @shops[start, count]
        render json: @shops, meta: { status: :ok, total: @shops.count }, meta_key: 'result'
      end

      def search(latitude, longitude, region, area, district, genre, cuisine, period, budget, start, count)
        
        if area.eql?('Around')
          # 此时的district实际为半径大小
          @shops = Shop.near([latitude, longitude], district.to_i / 1000).limit(500)
        elsif area.eql?('All')
          @shops = Shop.where(region: region).limit(500)
        else
          @shops = Shop.where(region: region, area: area, district: district).limit(500)
        end

        if !genre.eql?('All')
          @shops = @shops.where(genre: genre, cuisine: cuisine)
        end

        if period.eql?('Lunch')
          if budget.to_i > 10000
            @shops = @shops.where("lunch_budget_average > 10000")
          else
            @shops = @shops.where("lunch_budget_average < #{budget.to_i + 500} and lunch_budget_average > #{budget.to_i - 500}")
          end
        elsif period.eql?('Dinner')
          if budget.to_i > 10000
            @shops = @shops.where("dinner_budget_average > 10000")
          else
            @shops = @shops.where("dinner_budget_average < #{budget.to_i + 500} and dinner_budget_average > #{budget.to_i - 500}")
          end
        end

        @shops = @shops[start, count]

        #@shops = Shop.where(extern_id: '01096232')
        render json: @shops, meta: { status: :ok, total: @shops.count }, meta_key: 'result'
      end

      def favor(user_id, start, count)
        user = User.find(user_id)
        @shops = user.shops
        @shops = @shops[start, count]
        render json: @shops, meta: { status: :ok, count: @shops.count }, meta_key: 'result'
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end