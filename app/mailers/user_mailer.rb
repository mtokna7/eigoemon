class UserMailer < ApplicationMailer
  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: '英語えもん (in the Edo era)')
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to 英語えもん！')
  end
end


