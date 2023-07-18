module Api
  module V1
    class UsersController < ApplicationController

      def index
        users = User.all

        render json: {
          users: users
        }
      end

      def show
        user = User.find(params[:id])

        render json: {
          user: user
        }
      end

      def create
        user = User.new(user_params)
        # binding.pry
        if user.save
          login!(user)
          # binding.pry
          render json: {
            user: user
          }
        else
          render json: {
            status: 500
          }
        end
      end

      private
      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

    end
  end
end