# user creation
User.create!(
  name: 'Test Name',
  email: 'test@mail.com',
  password: 'foobar01',
  password_confirmation: 'foobar01',
  admin: true
)

50.times do |n|
  name = Faker::Name.name
  email = "test_#{n + 1}@mail.com"
  password = 'password'
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
end

# label creation
10.times do |n|
  name = "test_label#{n + 1}"
  Label.create!(
    name: name
  )
end

first_user = User.first
3.times do |n|
  title = "New task #{n + 1}"
  content = "Test task #{n + 1}"
  priority = n
  deadline = Time.zone.now + (n + 1)
  task_status = n
  task = first_user.tasks.create!(
    title: title,
    content: content,
    priority: priority,
    deadline: deadline,
    task_status: task_status
  )
  task.label_ids = [(n + 1), (n + 2), (n + 3)]
end

users = User.order(:created_at).take(5)
50.times do |n|
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  priority = rand(0..2)
  deadline = Time.zone.now + 60 * 60 * 24 * (n + 1)
  task_status = rand(0..2)
  users.each do |user|
    task = user.tasks.create!(
      title: title,
      content: content,
      priority: priority,
      deadline: deadline,
      task_status: task_status
    )
    task.label_ids = rand(1..10)
  end
end
