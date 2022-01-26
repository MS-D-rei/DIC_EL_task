3.times do |n|
  title = "New task #{n + 1}"
  content = "Test task #{n + 1}"
  priority = n
  deadline = Time.zone.now + (n + 1)
  task_status = n
  Task.create!(
    title: title,
    content: content,
    priority: priority,
    deadline: deadline,
    task_status: task_status
  )
end

50.times do |n|
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  priority = rand(0..2)
  deadline = Time.zone.now + 60 * 60 * 24 * n
  task_status = rand(0..2)
  Task.create!(
    title: title,
    content: content,
    priority: priority,
    deadline: deadline,
    task_status: task_status
  )
end
