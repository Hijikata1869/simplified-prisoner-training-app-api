module Api
  module V1
    class TrainingLogsController < ApplicationController
      
      def index
        training_logs = TrainingLog.all

        render json: {
          trainingLogs: training_logs
        }
      end

      def show
        training_log = TrainingLog.find(params[:id])

        render json: {
          trainingLog: training_log
        }, status: :ok
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