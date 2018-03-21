class Timer < ApplicationRecord
  belongs_to :user

  validates :study_length, :short_break_length, :long_break_length,
              numericality: { only_integer: true, greater_than: 0 }
end
