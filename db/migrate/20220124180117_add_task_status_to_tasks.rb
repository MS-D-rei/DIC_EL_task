class AddTaskStatusToTasks < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE task_status AS ENUM ('not_started', 'doing', 'completed');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE task_status;
    SQL
  end
end
