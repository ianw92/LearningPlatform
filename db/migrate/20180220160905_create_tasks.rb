class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :todo_list, foreign_key: true
      t.string :title
      t.string :description
      t.datetime :due_date
      t.boolean :completed

      t.timestamps
    end
  end
end
