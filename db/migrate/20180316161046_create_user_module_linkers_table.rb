class CreateUserModuleLinkersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :user_module_linkers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :lecture_module, index: true
      t.timestamps
    end
  end
end
