class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 100 }
  validates :priority, presence: true
  validates :task_status, presence: true

  enum task_status: { not_started: 0, doing: 1, completed: 2 }
end
