require 'rails_helper'

# bundle exec rspec spec/system/sessions_spec.rb

RSpec.describe "Sessions", type: :system do
  let!(:first_user) { FactoryBot.create(:user, admin: true) }
  let!(:second_user) { FactoryBot.create(:user, name: 'Second User', email: 'test_2@mail.com') }
  let!(:first_user_task1) { FactoryBot.create(:task, user: first_user) }

  describe '#create' do
    context 'log in' do
      it "show the user's task page" do
        visit login_path
        first_user_log_in
        expect(page).to have_content first_user_task1.content
      end
    end
  end

  describe '#destroy' do
    context 'click log out' do
      it 'show the log in page' do
        visit login_path
        first_user_log_in
        sleep(0.5)
        click_on 'log out'
        expect(page).to have_button 'Log in'
      end
    end
  end

  describe 'access without login' do
    context 'access task index page without login' do
      it 'redirect to login page' do
        visit tasks_path
        expect(page).to have_button 'Log in'
      end
    end
  end
end
