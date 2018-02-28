class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :title, :user, presence: true

  validate :user_must_exist

  def user_must_exist
    if User.where("username = ?", user).blank?
      errors.add(:user, "doesn't exist")
    end
  end
end
