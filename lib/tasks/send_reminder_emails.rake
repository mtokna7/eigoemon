namespace :send_reminder_emails do
  desc "Send reminder emails to users who haven't logged in for a month"
  task send: :environment do
    users = User.where("last_sign_in_at < ?", 1.month.ago) 
    users.each do |user|
      UserMailer.reminder_email(user).deliver_now
    end
  end
end
