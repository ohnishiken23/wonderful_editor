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
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

        def user_params
          # params.require(:user).permit(:name, :email, :password)
          params.permit(:name, :email, :password)
        end
    end
  end
end
