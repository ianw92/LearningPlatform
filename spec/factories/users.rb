FactoryBot.define do

  factory :user do
    email "test@example.com"
    username "test"
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end

end
