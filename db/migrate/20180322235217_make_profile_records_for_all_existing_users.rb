class MakeProfileRecordsForAllExistingUsers < ActiveRecord::Migration[5.1]
  def change
    users = User.all
    users.each do |user|
      profile = Profile.new(user_id: user, sort_tasks_by: 0)
      profile.save
    end
  end
end
