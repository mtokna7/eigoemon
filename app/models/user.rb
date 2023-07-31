class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_quiz_histories, dependent: :destroy

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }  
end
