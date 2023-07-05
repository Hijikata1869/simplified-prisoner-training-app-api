module Api
  module V1
    class UsersController < ApplicationController

      def index
        users = User.all

        render json: {
          users: users
        }, status: :ok
      end

      def show
        user = User.find(params[:id])

        render json: {
          user: user
        }, status: :ok
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: {
            user: user
          }, status: :ok
        else
          render json: {
            message: "ユーザーを作成できませんでした"
          }, status: 422
        end
      end

      private
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

    end
  end
end