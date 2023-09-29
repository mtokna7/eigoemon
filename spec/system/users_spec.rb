require 'rails_helper'

RSpec.describe "User management", type: :system do
  describe "registration process" do
    it "registers a new user with name" do
      visit new_user_registration_path

      fill_in "user[name]", with: "Test User"
      fill_in "user[email]", with: "test@example.com"
      fill_in "user[password]", with: "password123"
      fill_in "user[password_confirmation]", with: "password123"
      click_button "会員とうろく"

      expect(page).to have_content "アカウント登録が完了しました。"
    end
  end

  describe "login process" do
    let(:user) { create(:user) }

    it "logs in an existing user" do
      visit new_user_session_path

      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: "password123"
      click_button "ログイン"

      expect(page).to have_content "ログインしました。"
    end
  end

  describe "editing user information" do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path

      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: "password123"
      click_button "ログイン"
    end

    it "logs out the logged-in user" do
      find('summary', text: user.name.upcase).click
      click_link "ログアウト"
  
      # アラートのハンドリング
      page.driver.browser.switch_to.alert.accept
  
      expect(current_path).to eq(root_path)
      expect(page).to have_content "ログアウトしました。"
    end
  end  
end
