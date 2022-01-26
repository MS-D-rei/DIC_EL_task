FactoryBot.define do
  factory :task do
    title { 'First task 1' }
    content { 'FactoryBot task 1' }
    priority { 'high' }
    deadline { Time.zone.now }
    task_status { 'not_started' }
  end
end
