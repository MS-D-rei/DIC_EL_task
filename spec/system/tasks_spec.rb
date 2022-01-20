require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let!(:first_task) { FactoryBot.create(:task) }
  let!(:second_task) { FactoryBot.create(:task, content: 'test task 2') }

  describe '#new' do
    context 'make a new task' do
      it 'create a new task and redirect to root' do
        visit new_task_path
        fill_in 'Title', with: 'new task 1'
        fill_in 'Content', with: 'create new task'
        fill_in 'Priority', with: '1'
        fill_in 'Deadline', with: Time.zone.now
        fill_in 'Status', with: 'doing'
        click_on 'create task'
        visit tasks_path
        expect(page).to have_content 'create new task'
      end
    end
  end

  describe '#index' do
    context 'get index path' do
      it 'show all created tasks' do
        visit tasks_path
        expect(page).to have_content first_task.content
        expect(page).to have_content second_task.content
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
