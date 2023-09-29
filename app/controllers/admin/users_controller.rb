module Admin
  class UsersController < ApplicationController
    layout 'admin'
    before_action :admin_user

    def index
      @users = User.all.order("created_at DESC")
    end

    def destroy
      user = User.find(params[:id])
      if user == current_user
        redirect_to admin_users_path, alert: t('users.destroy.self_deletion_alert')
      else
        user.destroy!
        redirect_to admin_users_path
      end
    end

    private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  end
end
