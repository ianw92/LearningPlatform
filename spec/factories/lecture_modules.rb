FactoryBot.define do

  factory :lecture_module do
    code 'TEST123'
    academic_year_end 2018
    semester 'Spring'
    name 'Test Module'
    user
  end

end
