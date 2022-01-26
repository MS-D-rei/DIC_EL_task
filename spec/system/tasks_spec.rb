require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:tasks) { Task.all }
  let!(:first_task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:task, title: 'Second task 2', deadline: Time.zone.now + 60 * 60 * 24, task_status: 'doing') }

  describe '#new' do
    context 'make a new task' do
      it 'create a new task and redirect to root' do
        visit new_task_path
        fill_in 'task[title]', with: 'new task 1'
        fill_in 'task[content]', with: 'create new task'
        fill_in 'task[priority]', with: 'middle'
        select_date('2022,1,25', from: '期日')
        select_time('18', '00', from: '期日')
        find('#task_task_status').find("option[value='not_started']").select_option
        click_on 'create task'
        visit tasks_path
        expect(page).to have_content 'create new task'
      end
    end
  end

  describe '#index' do
    before do
      visit tasks_path
    end
    context 'get index path' do
      it 'show all created tasks' do
        expect(page).to have_content first_task.content
        expect(page).to have_content second_task.content
      end
      it 'show all tasks with descending order' do
        newest_task = FactoryBot.create(:task, title: 'newest task', content: 'newest task 1' )
        visit root_path
        expect(first('#task_title')).to have_content newest_task.title
      end
    end

    context 'use searchbar without keyword and status' do
      it 'show all created tasks' do
        expect(page).to have_content first_task.content
        expect(page).to have_content second_task.content
      end
    end

    context 'use searchbar with keyword' do
      let(:search_keyword) { 'First' }
      let(:not_keyword) { 'Second' }
      it 'show tasks that include the keyword in their titles.' do
        fill_in 'task_search[keyword]', with: search_keyword
        find('.search-icon').click
        expect(page).to have_content first_task.title
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
        expect(page).to have_content first_task.title
        expect(all('#task_title')).to_not include not_keyword
        expect(first('#task_status')).to have_content 'not_started'
        expect(all('#task_status')).to_not have_content 'doing'
      end
    end

    context 'sort tasks with deadline' do
      it 'show tasks ascending order of deadline' do
        click_link '期日'
        sleep(1)
        expect(first('#task_deadline')).to have_content first_task.deadline.strftime("%F")
        click_link '期日'
        sleep(1)
        expect(first('#task_deadline')).to have_content second_task.deadline.strftime("%F")
      end
    end
  end

  describe '#show' do
    context 'click show button' do
      it 'show the details of the task' do
        visit task_path(first_task)
        expect(page).to have_content first_task.content
        expect(page).to have_content first_task.priority
        expect(page).to have_content first_task.deadline
        expect(page).to have_content first_task.task_status
      end
    end
  end
end
