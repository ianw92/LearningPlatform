json.extract! subtask, :id, :task_id, :title, :due_date, :completed, :created_at, :updated_at
json.url subtask_url(subtask, format: :json)
