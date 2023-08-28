module Api
  module V1
    class SessionsController < ApplicationController
      def index
        if logged_in?
          render json: {
            loggedIn: true
          }
        else
          render json: {
            loggedIn: false
          }
        end
      end

      def create
        email = params[:email]
        password = params[:password]
        if login(email, password)
          session_id = session.id.public_id
          user = User.find(session[:user_id])
          render json: {
            sessionId: session_id,
            user: user
          }, status: 200
        else
          render json: {
            message: "ログインできませんでした"
          }, status: 500
        end
      end

      def destroy
        if cookies["_pta_session"].present?
          session.delete(:user_id)
          render json: {
            message: "ログアウトしました"
          }, status: 200
        else
          render json: {
            message: "ログアウトできませんでした"
          }, stauts: 500
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