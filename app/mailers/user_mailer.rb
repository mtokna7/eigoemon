class UserMailer < ApplicationMailer
  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: '英語えもん (in the Edo era)')
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'ようこそ、英語えもんへ！')
  end
end


