require 'rails_helper'

# bundle exec rspec spec/system/tasks_spec.rb

RSpec.describe "Tasks", type: :system do
  let(:tasks) { Task.all }
  let!(:first_user) { FactoryBot.create(:user, admin: true) }
  let!(:second_user) { FactoryBot.create(:user, name: 'Second User', email: 'test_2@mail.com') }
  let!(:first_user_task1) { FactoryBot.create(:task, user: first_user) }
  let!(:first_user_task2) { FactoryBot.create(:task, title: 'Second task', content: 'FactoryBot task 2', deadline: Time.zone.now + 60 * 60 * 24, task_status: 'doing', user: first_user) }
  let!(:label_1) { FactoryBot.create(:label) }
  let!(:label_2) { FactoryBot.create(:label, name: 'label2') }

  describe '#new' do
    before do
      visit login_path
      first_user_log_in
      sleep(0.5)
    end

    context 'make a new task' do
      it 'create a new task and redirect to root' do
        visit new_task_path
        fill_in 'task[title]', with: 'new task 1'
        fill_in 'task[content]', with: 'New task content'
        fill_in 'task[priority]', with: 'middle'
        select_date('2022,1,25', from: '期日')
        select_time('18', '00', from: '期日')
        find('#task_task_status').find("option[value='not_started']").select_option
        check 'label1'
        click_on 'create task'
        expect(page).to have_content 'New task content'
        expect(page).to have_content 'label1'
      end
    end
  end

  describe '#index' do
    before do
      visit login_path
      first_user_log_in
      sleep(0.5)
    end
    context 'get index path' do
      it 'show all created tasks' do
        expect(page).to have_content first_user_task1.content
        expect(page).to have_content first_user_task2.content
      end
      it 'show all tasks with descending order' do
        newest_task = FactoryBot.create(:task, title: 'newest task', content: 'newest task 1', user: first_user )
        visit root_path
        expect(first('#task_title')).to have_content newest_task.title
      end
    end

    context 'use searchbar without keyword and status' do
      it 'show all created tasks' do
        expect(page).to have_content first_user_task1.content
        expect(page).to have_content first_user_task2.content
      end
    end

    context 'use searchbar with keyword' do
      let(:search_keyword) { 'First' }
      let(:not_keyword) { 'Second' }
      it 'show tasks that include the keyword in their titles.' do
        fill_in 'task_search[keyword]', with: search_keyword
        find('.search-icon').click
        expect(page).to have_content first_user_task1.title
        expect(all('#task_title')).to_not include not_keyword
      end
    end

    context 'use searchbar with task_status' do
      it 'show tasks that have the status' do
        find('#task_search_status_num').find("option[value='0']").select_option
        find('.search-icon').click
        expect(first('#task_status')).to have_content 'not_started'
        expect(all('#task_status')).to_not include 'doing'
      end
    end

    context 'use searchbar with keyword and task_status both' do
      let(:search_keyword) { 'First' }
      let(:not_keyword) { 'Second' }
      it 'show tasks that have both' do
        fill_in 'task_search[keyword]', with: search_keyword
        find('#task_search_status_num').find("option[value='0']").select_option
        find('.search-icon').click
        expect(page).to have_content first_user_task1.title
        expect(all('#task_title')).to_not include not_keyword
        expect(first('#task_status')).to have_content 'not_started'
        expect(all('#task_status')).to_not have_content 'doing'
      end
    end

    context 'sort tasks with deadline' do
      it 'show tasks ascending order of deadline' do
        click_link '期日'
        sleep(0.5)
        expect(first('#task_deadline')).to have_content first_user_task1.deadline.strftime("%F")
        click_link '期日'
        sleep(0.5)
        expect(first('#task_deadline')).to have_content first_user_task2.deadline.strftime("%F")
      end
    end

    context 'search by label' do
      it 'show tasks that have the seleted label' do
        add_labels(first_user_task1, 'label1')
        add_labels(first_user_task2, 'label2')
        select 'label2', from: 'label_id'
        click_on 'search'
        sleep(0.5)
        expect(page).to have_content 'label2'
        expect(all('#task_label')).not_to include 'label1'
      end
    end
  end

  describe '#show' do
    before do
      visit login_path
      first_user_log_in
      sleep(0.5)
    end

    context 'click show button' do
      it 'show the details of the task' do
        visit task_path(first_user_task1)
        sleep(0.5)
        expect(page).to have_content first_user_task1.content
        expect(page).to have_content first_user_task1.priority
        expect(page).to have_content first_user_task1.task_status
      end
    end
  end
end
