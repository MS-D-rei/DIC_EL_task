class AddNotnullToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :content, :text, null: false
    change_column :tasks, :priority, :string, null: false
  end
end
