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

        @shops = Shop.where("latitude < ? AND latitude > ? AND longitude < ? AND longitude > ?",
                            (latitude + radius/111), (latitude - radius/111), (longitude + radius/111), (longitude - radius/111)).limit(100)
        render json: @shops.to_json
      end

      def show
        respond_with Shop.find(params[:id])
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

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end
    end
  end
end