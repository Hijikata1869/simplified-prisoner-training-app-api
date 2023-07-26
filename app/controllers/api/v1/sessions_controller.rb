module Api
  module V1
    class SessionsController < ApplicationController
      def index
        if session[:user_id].present?
          render json: {
            loggedIn: true
          }, status: 200
        else
          render json: {
            loggedIn: false
          }, status: 200
        end
      end

      def create
        email = params[:email]
        password = params[:password]
        if login(email, password)
          binding.pry
          session_id = session.id.public_id
          user = User.find(session[:user_id])
          render json: {
            session_id: session_id,
            user: user
          }, status: 200
        else 
          render json: {
            message: "ログインに失敗しました"
          }, status: 401
        end
      end

      def destroy
        if session.id.public_id == params[:session_id]
          session[:user_id] = nil
          render json: {
            message: "ログアウトしました"
          }, status: 200
        else
          render json: {
            message: "ログアウトに失敗しました"
          }, statu: 500
        end
      end

      private
      def login(email, password)
        user = User.find_by(email: email)

        return false unless user && user.authenticate(password)
        session[:user_id] = user.id
        true
      end

    end
  end
end