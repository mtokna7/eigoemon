class Conversation < ApplicationRecord
  validates :level, presence: true
  validates :content, presence: true
  validates :speaker, presence: true
  validates :order, presence: true, uniqueness: { scope: :level }
  enum speaker: { boku: 0, eigoemon: 1, anothers: 2 }
  scope :for_level, ->(level) { where(level: level).order(:order) }
end
