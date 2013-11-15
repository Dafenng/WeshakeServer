module Api
  module V1
    class PostsController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access
      respond_to :json

      # GET /posts
      # GET /posts.json
      def index
        @user = User.find(params[:user_id])
        if @user.auth_token == params[:auth_token]
          @posts = @user.posts.reverse_order
          start = params[:start].to_i
          count = params[:count].to_i
          @posts = @posts[start, count]
          render json: @posts, meta: { status: :ok, count: @posts.count }, meta_key: 'result'
        else
          render json: 'Permission Denied'
        end
      end

      # GET /posts/1
      # GET /posts/1.json
      def show
        @post = Post.find(params[:id])
        render json: @post, meta: { status: :ok }, meta_key: 'result'
      end

      # POST /posts
      # POST /posts.json
      def create
        @post = Post.new(post_params)
        @post.user_id = params[:user_id]
        if @post.save
          render json: @post, meta: { status: :created }, meta_key: 'result', status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /posts/1
      # PATCH/PUT /posts/1.json
      def update
        respond_with post.update(params[:id], params[:post])
      end

      # DELETE /posts/1
      # DELETE /posts/1.json
      def destroy
        respond_with post.destroy(params[:id])
      end

      private

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

      def post_params
        params.require(:post).permit(:message, :photo)
      end

    end
  end
end