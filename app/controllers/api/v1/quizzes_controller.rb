module Api
    module V1
      class QuizzesController < ApplicationController
        before_action :authenticate_user!

        rescue_from ActiveRecord::RecordNotFound do |exception|
            render json: { error: exception.message }, status: :not_found
        end

        def conversations
            @conversations = Conversation.where(level: current_user.level).order(:order)
            render json: { conversations: @conversations }
          end
          
      end
    end
  end
  