50.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  Task.create!(
    title: title,
    content: content,
    priority: rand(0..3),
    deadline: Time.zone.now,
    status: %w[not-yet doing completed].sample
  )
end
