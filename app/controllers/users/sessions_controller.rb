class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    super do
      resource.update(last_sign_in_at: Time.current)
    end
  end
end
