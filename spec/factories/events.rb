FactoryGirl.define do
  
  factory :invalid_event, class: Event do |f|
  	f.name ""
  	f.occurrence 1 
  	f.start_at "#{Date.today - 1.minute}"
  	f.frequency 1  
  	f.job_name ""
  	f.job_arguments ""
  	f.priority 10
  	f.job_id 2
  	f.execution_time [1, 2, 3]
  end

  factory :invalid_event_result, class: EventResult do |f|  	
	f.event_id ""	
	f.job_id	""	
	f.queue	""
	f.attempts	""
	f.last_error ""	
	f.priority	""
	f.locked_by	""
	f.run_at	"#{Date.today - 1.minute}"
	f.failed_at	""
	f.created_at ""
	f.updated_at ""
	f.status	 ""	
  end
end