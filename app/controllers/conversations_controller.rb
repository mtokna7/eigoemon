class ConversaionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    dialogues = Dialogue.where(level: user.level).order(:created_at).pluck(:content)
    render json: { dialogues: dialogues }
  end
end
