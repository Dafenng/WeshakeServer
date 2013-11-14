module Api
  module V1
    class ShopPhotosController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access
      respond_to :json

      # GET /shop_photos
      # GET /shop_photos.json
      def index
        shop = Shop.find(params[:shop_id])
        @shop_photos = shop.shop_photos
        render json: @shop_photos, meta: { status: :ok, total: @shop_photos.count }, meta_key: 'result'
      end

      # GET /shop_photos/1
      # GET /shop_photos/1.json
      def show
        @shop_photo = ShopPhoto.find(params[:id])
        render json: @shop_photo, meta: { status: :ok }, meta_key: 'result'
      end

      # POST /shop_photos
      # POST /shop_photos.json
      def create


      end

      # PATCH/PUT /shop_photos/1
      # PATCH/PUT /shop_photos/1.json
      def update
        respond_with ShopPhoto.update(params[:id], params[:shop_photo])
      end

      # DELETE /shop_photos/1
      # DELETE /shop_photos/1.json
      def destroy
        respond_with ShopPhoto.destroy(params[:id])
      end

      private

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

      def shop_photo_params
        params.require(:shop_photo).permit(:shop_id)
      end

    end
  end
end