class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def handle_level_up
    if level_up_conditions_met?
      @level_up = true
      @conversations = Conversation.where(level: current_user.level).order(:order)
      reset_flags
    else
      @level_up = false
    end
  end

  def level_up_conditions_met?
    current_user.leveled_up || (current_user.level.zero? && current_user.first_visit)
  end

  def reset_flags
    current_user.update(leveled_up: false, first_visit: false)
  end
end
