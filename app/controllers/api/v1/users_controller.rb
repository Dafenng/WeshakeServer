module Api
  module V1
    class UsersController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access
      respond_to :json

      # GET /users
      # GET /users.json
      def index
        respond_with User.all
      end

      # GET /users/1
      # GET /users/1.json
      def show
        respond_with User.find(params[:id])
      end

      # POST /users
      # POST /users.json
      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user.to_json, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
        respond_with User.update(params[:id], params[:user])
      end

      # DELETE /users/1
      # DELETE /users/1.json
      def destroy
        respond_with User.destroy(params[:id])
      end

      private

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

      def user_params
        params.require(:user).permit(:username, :avatar)
      end

    end
  end
end