json.extract! note, :id, :user_id, :lecture_module_id, :week, :notes, :created_at, :updated_at
json.url note_url(note, format: :json)
