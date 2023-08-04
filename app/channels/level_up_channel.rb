class LevelUpChannel < ApplicationCable::Channel
  def subscribed
    stream_from "level_up_#{params[:user_id]}"
  end
end
