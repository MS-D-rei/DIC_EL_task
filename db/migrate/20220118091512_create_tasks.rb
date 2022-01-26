class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.integer :priority, null: false, default: 0
      t.datetime :deadline
      t.integer :task_status, null: false, default: 0

      t.timestamps
    end
  end
end
