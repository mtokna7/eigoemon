class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.for_level(current_user.level)
    render json: { conversations: @conversations }
  end
end
