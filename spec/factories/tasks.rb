FactoryBot.define do

  factory :task do
    todo_list
    title "Task test"
    due_date Date.today
    completed false
  end

end
