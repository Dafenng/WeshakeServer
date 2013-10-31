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

        process = params[:process]
        if process.eql?('suggest')
          suggest(latitude, longitude, radius)
        elsif process.eql?('around')
          around(latitude, longitude)
        elsif process.eql?('search')
          search_type = params[:search_type]
          start = params[:start].to_i
          count = params[:count].to_i
          if search_type.eql?('search_location')
            search_location(latitude, longitude, radius, start, count)
          elsif search_type.eql?('search_cuisine')
            cuisine = params[:cuisine]
            search_cuisine(latitude, longitude, cuisine, start, count)
          elsif search_type.eql?('search_budget')
            from = params[:from].to_i
            to = params[:to].to_i
            search_budget(latitude, longitude, from, to, start, count)
          end
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

      def suggest(latitude, longitude, radius)
        @shops = Shop.where("latitude < #{latitude + radius/111} AND latitude > #{latitude - radius/111}
                            AND longitude < #{longitude + radius/111} AND longitude > #{longitude - radius/111}").limit(100)
        @shop = @shops.sample
        render json: @shop, meta: { status: :ok, total: @shops.count }, meta_key: 'result'
      end

      def around(latitude, longitude)
        @shops = Shop.near([latitude, longitude], 5).limit(10)
        render json: @shops, meta: { status: :ok, total: @shops.count }, meta_key: 'result'
      end

      def search_location(latitude, longitude, radius, start, count)
        @shops = Shop.where("latitude < #{latitude + radius/111} AND latitude > #{latitude - radius/111}
                            AND longitude < #{longitude + radius/111} AND longitude > #{longitude - radius/111}").limit(100)
        @shops = @shops[start, count]
        render json: @shops, meta: { status: :ok, count: @shops.count }, meta_key: 'result'
      end

      def search_cuisine(latitude, longitude, cuisine, start, count)
        @shops = Shop.where("latitude < #{latitude + 5/111} AND latitude > #{latitude - 5/111}
                            AND longitude < #{longitude + 5/111} AND longitude > #{longitude - 5/111} AND
                            cuisine = #{cuisine}").limit(100)
        @shops = @shops[start, count]
        render json: @shops, meta: { status: :ok, count: @shops.count }, meta_key: 'result'
      end

      def search_budget(latitude, longitude, from, to, start, count)
        @shops = Shop.where("latitude < #{latitude + 5/111} AND latitude > #{latitude - 5/111}
                            AND longitude < #{longitude + 5/111} AND longitude > #{longitude - 5/111} AND
                            cost > #{from} AND cost < #{to}").limit(100)
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