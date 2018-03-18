class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  validates :title, presence: true

  # validate :user_must_exist
  #
  # def user_must_exist
  #   if User.where("username = ?", user).blank?
  #     errors.add(:user, "doesn't exist")
  #   end
  # end
end
