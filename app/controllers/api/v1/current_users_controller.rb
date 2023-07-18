module Api
  module V1
    class CurrentUsersController < ApplicationController

      def show
        redis = Redis.new(:host => "localhost", :port => 6379, :db => 0)
        namespace = "_session_id:2"
        session_id =  Digest::SHA256.hexdigest(params[:session_id].to_s)
        session_key = "#{namespace}::#{session_id}"
        binding.pry
        session_user_id = Marshal.load(redis.get(session_key))["user_id"]
        current_user = User.find(session_user_id)
        if current_user.present?
          render json: {
            current_user: current_user
          }, status: 200
        else
          render json: {
            message: "ログインしていません"
          }, status: 500
        end
      end

    end
  end
end