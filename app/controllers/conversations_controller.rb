class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.where(level: current_user.level).order(:order)
    render json: { conversations: @conversations }
  end
end
