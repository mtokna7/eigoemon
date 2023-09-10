class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :word
  validates :word_id, uniqueness: { scope: :user_id }
end
