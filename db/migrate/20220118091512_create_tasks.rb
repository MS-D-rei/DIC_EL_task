class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.string :priority
      t.datetime :deadline
      t.string :status

      t.timestamps
    end
  end
end
