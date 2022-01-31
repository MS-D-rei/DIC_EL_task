FactoryBot.define do
  factory :user do
    name { 'First User' }
    email { "test@mail.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end
end
