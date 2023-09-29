FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    name { "Test User" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
