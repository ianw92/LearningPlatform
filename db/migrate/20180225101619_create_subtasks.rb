class CreateSubtasks < ActiveRecord::Migration[5.1]
  def change
    create_table :subtasks do |t|
      t.references :task, foreign_key: true
      t.string :title
      t.date :due_date
      t.boolean :completed

      t.timestamps
    end
  end
end
