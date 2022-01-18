class Task < ApplicationRecord
  validates :content, presence: true, length: { maximum: 100 }
  validates :priority, presence: true
  validates :status, presence: true
end
