json.extract! task, :id, :todo_list_id, :title, :description, :due_date, :completed, :created_at, :updated_at
json.url task_url(task, format: :json)