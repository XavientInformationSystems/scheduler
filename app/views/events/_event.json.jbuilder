json.extract! event, :id, :name, :frequency, :at, :job_name, :job_arguments, :created_at, :updated_at
json.url event_url(event, format: :json)
