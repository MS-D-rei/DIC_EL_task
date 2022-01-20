require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:tasks) { Task.all }
  let!(:first_task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:task, title: 'test task 2') }

  describe '#new' do
    context 'make a new task' do
      it 'create a new task and redirect to root' do
        visit new_task_path
        fill_in 'task[title]', with: 'new task 1'
        fill_in 'task[content]', with: 'create new task'
        fill_in 'task[priority]', with: '1'
        fill_in 'task[deadline]', with: Time.zone.now
        fill_in 'task[status]', with: 'doing'
        click_on 'create task'
        visit tasks_path
        expect(page).to have_content 'create new task'
      end
    end
  end

  describe '#index' do
    context 'get index path' do
      before do
        visit tasks_path
      end
      it 'show all created tasks' do
        expect(page).to have_content first_task.content
        expect(page).to have_content second_task.content
      end
      it 'show all tasks with descending order' do
        newest_task = FactoryBot.create(:task, title: 'newest task', content: 'newest task 1' )
        expect(newest_task.title).to eq tasks.first.title
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
        expect(page).to have_content first_task.status
      end
    end
  end
end
