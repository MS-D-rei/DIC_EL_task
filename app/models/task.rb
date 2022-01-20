class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 100 }
  validates :priority, presence: true
  validates :status, presence: true

  default_scope -> { order(created_at: :desc) }
end
