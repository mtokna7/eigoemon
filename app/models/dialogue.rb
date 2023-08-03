class Dialogue < ApplicationRecord
  validates :level, presence: true
  validates :content, presence: true
  validates :speaker, presence: true
  
  enum speaker: { hero: 0, eigoemon: 1 }
  
end
