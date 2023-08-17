namespace :send_reminder_emails do
  desc "Send reminder emails to users who haven't logged in for a month"
  task send: :environment do
    users = User.where("last_login_at < ?", 1.minute.ago) #1.month.ago
    users.each do |user|
      UserMailer.reminder_email(user).deliver_now
    end
  end
end
  