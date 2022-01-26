require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#validates' do

    context 'when no title' do
      let(:no_title_task) { FactoryBot.build(:task, title: '') }
      it 'should be false' do
        expect(no_title_task.save).to be false
      end
    end

    context 'when no content' do
      let(:no_content_task) { FactoryBot.build(:task, content: '') }
      it 'should be false' do
        expect(no_content_task.save).to be false
      end
    end

    context 'when no priority' do
      let(:no_priority_task) { FactoryBot.build(:task, priority: '') }
      it 'should be false' do
        expect(no_priority_task.save).to be false
      end
    end

    context 'when no status' do
      let(:no_status_task) { FactoryBot.build(:task, task_status: '') }
      it 'should be false' do
        expect(no_status_task.save).to be false
      end
    end

    context 'fill all field except for deadline' do
      let(:no_deadline_task) { FactoryBot.build(:task, deadline: '') }
      it 'should be true' do
        expect(no_deadline_task.save).to be true
      end
    end
  end

  describe '#scope' do
    let!(:first_task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:task, title: 'Second task 2', task_status: 'doing') }
    let(:search_keyword) { 'First' }
    let(:not_keyword) { 'Second' }

    context 'use scope show_search_result with title keyword' do
      it 'shows tasks that have the title keyword' do
        expect(Task.show_search_result(search_keyword, "")).to include first_task
        expect(Task.show_search_result(search_keyword, "")).to_not include second_task
      end
    end

    context 'use scope show_search_result with status' do
      it 'shows tasks that have the status' do
        expect(Task.show_search_result("", '0')).to include first_task
        expect(Task.show_search_result("", '0')).to_not include second_task
      end
    end

    context 'use scope show_search_result with keyword and status' do
      it 'shows tasks that have the title keyword and status both' do
        expect(Task.show_search_result(search_keyword, '0')).to include first_task
        expect(Task.show_search_result(search_keyword, '0')).to_not include second_task
      end
    end
  end
end
