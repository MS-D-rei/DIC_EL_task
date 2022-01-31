require 'rails_helper'

# bundle exec rspec spec/system/users_spec.rb

RSpec.describe "Users", type: :system do
  let!(:first_user) { FactoryBot.create(:user, admin: true) }
  let!(:second_user) { FactoryBot.create(:user, name: 'Second User', email: 'test_2@mail.com') }
  let!(:first_user_task1) { FactoryBot.create(:task, user: first_user) }
  let!(:second_user_task1) { FactoryBot.create(:task, user: second_user) }

  describe '#new' do
    context 'create new account' do
      it 'increase the number of users by 1' do
        visit new_user_path
        fill_in 'user[name]', with: 'New user 1'
        fill_in 'user[email]', with: 'new1@mail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        expect { click_on 'create new account' }.to change { User.count }.by(1)
      end
    end
  end

  describe "access other user's page" do
    context "normal user accesss other user's page" do
      it "redirect to the normal user's task index" do
        visit new_task_path
        second_user_log_in
        visit user_path(first_user)
        expect(page).to have_content second_user_task1
      end
    end
  end
end
