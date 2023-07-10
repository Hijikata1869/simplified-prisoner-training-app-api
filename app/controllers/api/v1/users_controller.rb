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
        # binding.pry
        if user.save
          session[:user_id] = user.id
          # binding.pry
          render json: {
            user: user,
            sesison_id: session.id.public_id
          }, status: :ok
        else
          render json: {
            message: "ユーザーを作成できませんでした"
          }, status: 422
        end
      end

      private
      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

    end
  end
end