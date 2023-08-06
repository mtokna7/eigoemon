class Conversation < ApplicationRecord
  validates :level, presence: true
  validates :content, presence: true
  validates :speaker, presence: true
  validates :order, presence: true, uniqueness: { scope: :level }

  
  enum speaker: { hero: 0, eigoemon: 1 }
  
end