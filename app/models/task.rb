class Task < ApplicationRecord
  belongs_to :user, counter_cache: true

  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 100 }
  validates :priority, presence: true
  validates :task_status, presence: true

  enum priority: { high: 0, middle: 1, low: 2 }
  enum task_status: { not_started: 0, doing: 1, completed: 2 }

  scope :show_search_result, lambda { |keyword, status|
    if keyword.empty? && status.empty?
      Task.default_scoped.all
    elsif keyword.empty?
      Task.default_scoped.where('task_status = ?', status)
    elsif status.empty?
      Task.default_scoped.where('title LIKE(?)', "%#{keyword}%")
    else
      Task.default_scoped.where('title LIKE(?) and task_status = ?', "%#{keyword}%", status)
    end
  }

  # class << self
  #   def show_search_result(keyword, status)
  #     if keyword.empty? && status.empty?
  #       Task.all
  #     elsif keyword.empty?
  #       Task.where('task_status = ?', status)
  #     elsif status.empty?
  #       Task.where('title LIKE(?)', "%#{keyword}%")
  #     else
  #       Task.where('title LIKE(?) and task_status = ?', "%#{keyword}%", status)
  #     end
  #   end
  # end
end
