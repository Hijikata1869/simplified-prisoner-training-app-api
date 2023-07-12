module Api
  module V1
    class SessionsController < ApplicationController
      def new
        user_session = session[params[:session_id]]
        # binding.pry
      end

      def create
        email = params[:email]
        password = params[:password]
        
        if login(email, password)
          render json: {
            message: "ログインに成功しました"
          }, status: :ok
        else 
          render json: {
            message: "ログインに失敗しました"
          }, status: 401
        end
      end

      def destroy
        session[:user_id] = nil
        render json: {
          message: "ログアウトしました"
        }, status: :ok
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