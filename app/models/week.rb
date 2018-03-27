class Week < ApplicationRecord
  belongs_to :lecture_module
  has_many :lecture_module_contents, dependent: :destroy
end
