class ReccurringEvent
  include Delayed::RecurringJob
  
  run_every 1.day
  run_at '11:00am'
  timezone 'US/Pacific'
  queue 'slow-jobs'

  def perform
    # Do some work here!
    Rails.logger.debug "Executing Reccurring Job ******************************************************************"
    Event.start_job "python -v"
  end
end
