class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where(level: current_user.level).order(:order)
    render json: { conversations: @conversations }
  end
end
