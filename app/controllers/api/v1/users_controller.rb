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
        if user.save
          login(email, password)
          session_id = session.id.public_id
          render json: {
            user: user,
            session_id: session_id
          }, status: 200
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

      def login(email, password)
        user = User.find_by(email: email)

        return false unless user && user.authenticate(password)

        session[:user_id] = user.id
        true
      end

    end
  end
end