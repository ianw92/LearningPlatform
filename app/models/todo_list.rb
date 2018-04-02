class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  validates :title, presence: true

  def self.get_todo_lists_for_user(user)
    TodoList.where(user_id: user)
  end
end
