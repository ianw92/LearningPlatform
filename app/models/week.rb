class Week < ApplicationRecord
  belongs_to :lecture_module
  has_many :lecture_module_contents, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
