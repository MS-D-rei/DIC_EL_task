require 'rails_helper'

# bundle exec rspec spec/system/users_spec.rb

RSpec.describe "Users", type: :system do
  let!(:first_user) { FactoryBot.create(:user, admin: true) }
  let!(:second_user) { FactoryBot.create(:user, name: 'Second User', email: 'test_2@mail.com') }
  let!(:first_user_task1) { FactoryBot.create(:task, user: first_user) }
  let!(:second_user_task1) { FactoryBot.create(:task, user: second_user) }
  let!(:user_for_delete) { FactoryBot.create(:user, name: 'Delete User', email: 'delete@mail.com') }

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
        visit login_path
        second_user_log_in
        visit user_path(first_user)
        sleep(0.5)
        expect(page).to have_content second_user_task1.title
      end
    end
  end

  describe '#admin_user' do
    before do
      visit login_path
      first_user_log_in
      sleep(0.5)
      click_on 'Admin page'
    end

    context 'admin_user access admin page' do
      it 'show admin user index' do
        expect(page).to have_content 'Administration Page'
      end
    end

    context 'admin user can create a new user account' do
      it 'increase User.count by 1' do
        click_link 'Create new account'
        fill_in 'user[name]', with: 'New user 2'
        fill_in 'user[email]', with: 'new2@mail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        expect { click_on 'create new account' }.to change { User.count }.by(1)
      end
    end

    context "admin user access other user's show page" do
      it "show the user's task index" do
        visit user_path(second_user)
        sleep(0.5)
        expect(page).to have_content second_user_task1.content
      end
    end

    context "admin user can edit other user's profile" do
      it "update the user's profile" do
        visit edit_user_path(second_user)
        sleep(1)
        fill_in 'user[name]', with: 'Second User edited'
        fill_in 'user[email]', with: 'test_2@mail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'update profile'
        expect(second_user.reload.name).to eq 'Second User edited'
      end
    end

    context 'admin user can delete user' do
      it 'destroy user and User.count decrease by 1' do
        expect do
          find_link('削除', href: "/admin/users/#{user_for_delete.id}").click
          page.driver.browser.switch_to.alert.accept
          sleep(0.5)
        end.to change(User, :count).by(-1)
      end
    end
  end

  describe '#normal user' do
    context 'normal user access admin page' do
      it "can't access admin page. Even if tried, redirect to task index page" do
        visit login_path
        second_user_log_in
        expect(page).to_not have_content 'Admin page'
        visit admin_users_path
        expect(page).to have_content second_user_task1.title
      end
    end
  end
end
