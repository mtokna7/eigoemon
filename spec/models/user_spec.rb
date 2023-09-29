require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    # クイズと選択肢を作成
    @word = create(:word)
    create(:quiz_choice, quiz: @word.quiz, furigana: 'くりぃく', is_correct: true)
    create(:quiz_choice, quiz: @word.quiz, furigana: 'かりぃく', is_correct: false)
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    expect(user.valid?).to be_falsey
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    expect(user.valid?).to be_falsey
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      name: "Test User",
      email: "test@example.com",
      password: "password123"
    )
    user = User.new(
      name: "Test User",
      email: "test@example.com",
      password: "password123"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end    
end
