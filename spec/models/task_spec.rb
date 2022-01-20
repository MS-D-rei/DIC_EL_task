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
      let(:no_status_task) { FactoryBot.build(:task, status: '') }
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
end
