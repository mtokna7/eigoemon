class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :word
  validates :word_id, uniqueness: { scope: :user_id }
  scope :for_user, ->(user_id) { where(user_id: user_id).includes(:word).order('words.name') }
end
