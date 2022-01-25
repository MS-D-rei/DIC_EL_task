class AddIndexToTasksTitle < ActiveRecord::Migration[6.0]
  def up
    add_index :tasks, :title
  end

  def down
    remove_index :tasks, :title
  end
end
