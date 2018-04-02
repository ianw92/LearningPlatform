FactoryBot.define do

  factory :profile do
    user
    sort_tasks_by 0
    show_completed_tasks false
    show_notes false
    show_comments false
  end

end
