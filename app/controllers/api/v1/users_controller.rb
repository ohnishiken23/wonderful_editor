module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users, status: :ok, content_type: "application/json"
      end

      def show
      end

      def new
      end

      def create
      end
    end
  end
end
