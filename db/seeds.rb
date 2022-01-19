50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  Task.create!(
    content: content,
    priority: rand(0..3),
    deadline: Time.zone.now,
    status: %w[not-yet doing completed].sample(1)
  )
end
