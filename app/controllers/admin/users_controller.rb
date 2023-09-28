class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :admin_user

  def index
    @users = User.all.order("created_at DESC")
  end

  def destroy
  user = User.find(params[:id])
  if user == current_user
    redirect_to admin_users_path, alert: '自分自身を削除することはできません。'
  else
    user.destroy!
    redirect_to admin_users_path, notice: '削除しました'
  end
end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
