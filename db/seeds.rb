50.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  priority = rand(0..3)
  deadline = Time.zone.now
  status = %w[not-yet doing completed].sample
  Task.create!(
    title: title,
    content: content,
    priority: priority,
    deadline: deadline,
    status: status
  )
end
