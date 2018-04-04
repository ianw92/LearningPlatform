FactoryBot.define do

  factory :task do
    todo_list
    title "Test Task"
    due_date Date.today
    completed false
  end

end
