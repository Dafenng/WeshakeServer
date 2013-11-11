module Api
  module V1
    class FavorsController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access
      respond_to :json

      # GET /favors
      # GET /favors.json
      def index
        @exist_favor = Favor.find_by(user_id: favor_params[:user_id], shop_id: favor_params[:shop_id])
        if @exist_favor.nil?
          render json: @exist_favor, meta: { status: :nonexistent }, meta_key: 'result'
        else
          render json: @exist_favor, meta: { status: :existent }, meta_key: 'result'
        end
      end

      # GET /favors/1
      # GET /favors/1.json
      def show
        @favor = Favor.find(params[:id])
        render json: @favor, meta: { status: :ok }, meta_key: 'result'
      end

      # POST /favors
      # POST /favors.json
      def create
        # 根据类型和相应类型下Favor判别
        @exist_favor = Favor.find_by(user_id: favor_params[:user_id], shop_id: favor_params[:shop_id])
        unless @exist_favor.nil?
          if @exist_favor.destroy
            render json: @exist_favor, meta: { status: :destroyed }, meta_key: 'result'
          else
            render json: @exist_favor.errors, status: :unprocessable_entity
          end

          return
        end

        @favor = Favor.new(favor_params)
        if @favor.save
          render json: @favor, meta: { status: :created }, meta_key: 'result', status: :created
        else
          render json: @favor.errors, status: :unprocessable_entity
        end

      end

      # PATCH/PUT /favors/1
      # PATCH/PUT /favors/1.json
      def update
        respond_with Favor.update(params[:id], params[:favor])
      end

      # DELETE /favors/1
      # DELETE /favors/1.json
      def destroy
        respond_with Favor.destroy(params[:id])
      end

      private

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

      def favor_params
        params.require(:favor).permit(:user_id, :shop_id)
      end

    end
  end
end