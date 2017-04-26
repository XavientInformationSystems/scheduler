class EventJob < Struct.new(:event)
 
  
  def enqueue(job)
    puts "Enqueing Job ***********"   
  end

  def before(job)
    puts "Before Perform ***********"
    update_event_and_its_result(event, "Processing", job)
  end

  def perform
    puts "Executing Job **********"
    Event.start_job event.job_arguments
  end 

  def after(job)
    puts "After perform *************"    
  end

  def success(job)    
    update_event_and_its_result(event, "Success", job)
  end

  def error(job, exception)    
    update_event_and_its_result(event, "Error", job)
  end

  def failure(job)            
    update_event_and_its_result(event, "Failure", job)
  end

  def update_event_and_its_result(event, status, job)       
    @event_result = EventResult.find_by(event_id: event.id, job_id: job.id)
    unless @event_result.nil?      
      @event_result.attempts = job.attempts
      @event_result.last_error = job.last_error
      @event_result.failed_at = job.failed_at
      @event_result.status = status
      @event_result.save(validate: false)

      puts "#{@event_result.inspect}"        
    end    
  end
end
