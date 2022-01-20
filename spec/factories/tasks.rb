FactoryBot.define do
  factory :task do
    title { 'test task 1' }
    content { 'test task 1111' }
    priority { '1' }
    deadline { Time.zone.now }
    status { 'doing' }
  end
end