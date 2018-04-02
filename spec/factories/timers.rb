FactoryBot.define do

  factory :timer do
    user
    study_length 25
    short_break_length 5
    long_break_length 10
  end

end
