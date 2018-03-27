class AddWeekReferenceToNote < ActiveRecord::Migration[5.1]
  def change
    add_reference :notes, :week, foreign_key: true
  end
end
