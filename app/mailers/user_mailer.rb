class UserMailer < ApplicationMailer
  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: t('defaults.eigoemon'))
  end
end
