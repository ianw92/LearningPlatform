FactoryBot.define do

  factory :user do
    email "testuser@example.com"
    username "Test User"
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end

end
