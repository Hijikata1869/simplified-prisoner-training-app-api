module Api
  module V1
    class TrainingLogsController < ApplicationController
      
      def index
        user_training_logs = []
        pushup = TrainingLog.where(user_id: params[:user_id], training_menu: "プッシュアップ").order(id: 'DESC').limit(1)[0]
        squat = TrainingLog.where(user_id: params[:user_id], training_menu: "スクワット").order(id: 'DESC').limit(1)[0]
        pullup = TrainingLog.where(user_id: params[:user_id], training_menu: "プルアップ").order(id: 'DESC').limit(1)[0]
        leg_raise = TrainingLog.where(user_id: params[:user_id], training_menu: "レッグレイズ").order(id: 'DESC').limit(1)[0]
        bridge = TrainingLog.where(user_id: params[:user_id], training_menu: "ブリッジ").order(id: 'DESC').limit(1)[0]
        handstand_pushup = TrainingLog.where(user_id: params[:user_id], training_menu: "ハンドスタンドプッシュアップ").order(id: 'DESC').limit(1)[0]
        user_training_logs.push(pushup, squat, pullup, leg_raise, bridge, handstand_pushup)
        user_training_logs.delete(nil)

        if user_training_logs.length != 0
          render json: {
            userTrainingLogs: user_training_logs
          }, status: 200
        else
          render json: {
            message: "トレーニング記録がありません"
          }, status: 500
        end
      end

      def show
      end

      def create
        training_log = TrainingLog.new(training_log_params)

        if training_log.save
          render json: {
            trainingLog: training_log
          }
        else
          render json: {
            status: 500
          }
        end
      end

      private
      def training_log_params
        params.require(:training_log).permit(:user_id, :training_menu, :step, :repetition, :set, :memo)
      end
    end
  end
end