require 'rails_helper'

# bundle exec rspec spec/models/task_spec.rb

RSpec.describe Task, type: :model do
  let!(:first_user) { FactoryBot.create(:user, admin: true) }
  let!(:first_user_task1) { FactoryBot.create(:task, user: first_user) }
  let!(:first_user_task2) { FactoryBot.create(:task, title: 'Second task', content: 'FactoryBot task 2', deadline: Time.zone.now + 60 * 60 * 24, task_status: 'doing', user: first_user) }
  let!(:search_keyword) { 'First' }
  let!(:not_keyword) { 'Second' }

  describe '#validates' do

    context 'when no title' do
      let(:no_title_task) { FactoryBot.build(:task, title: '', user: first_user) }
      it 'should be false' do
        expect(no_title_task.save).to be false
      end
    end

    context 'when no content' do
      let(:no_content_task) { FactoryBot.build(:task, content: '', user: first_user) }
      it 'should be false' do
        expect(no_content_task.save).to be false
      end
    end

    context 'when no priority' do
      let(:no_priority_task) { FactoryBot.build(:task, priority: '', user: first_user) }
      it 'should be false' do
        expect(no_priority_task.save).to be false
      end
    end

    context 'when no status' do
      let(:no_status_task) { FactoryBot.build(:task, task_status: '', user: first_user) }
      it 'should be false' do
        expect(no_status_task.save).to be false
      end
    end

    context 'fill all field except for deadline' do
      let(:no_deadline_task) { FactoryBot.build(:task, deadline: '', user: first_user) }
      it 'should be true' do
        expect(no_deadline_task.save).to be true
      end
    end
  end

  describe '#scope' do

    context 'use scope show_search_result with title keyword' do
      it 'shows tasks that have the title keyword' do
        expect(Task.show_search_result(search_keyword, "")).to include first_user_task1
        expect(Task.show_search_result(search_keyword, "")).to_not include first_user_task2
      end
    end

    context 'use scope show_search_result with status' do
      it 'shows tasks that have the status' do
        expect(Task.show_search_result("", '0')).to include first_user_task1
        expect(Task.show_search_result("", '0')).to_not include first_user_task2
      end
    end

    context 'use scope show_search_result with keyword and status' do
      it 'shows tasks that have the title keyword and status both' do
        expect(Task.show_search_result(search_keyword, '0')).to include first_user_task1
        expect(Task.show_search_result(search_keyword, '0')).to_not include first_user_task2
      end
    end
  end
end
