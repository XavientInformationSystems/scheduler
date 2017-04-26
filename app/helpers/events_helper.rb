module EventsHelper
	def get_event_status_class(status)
		case status
		when "Pending"
			"warning"
		when "Enqueued"
			"primary"
		when "Success"
			"success"
		when "Error"
			"danger"
		when "Failure"
			"danger"
		when "Scheduled"
			"info"
		end
	end

	def get_execution_time(time, frequency)
		case frequency
		when "minute-wise"
			time.to_i.minutes
		when "hour-wise"
			time.to_i.hours
		when "day-wise"
			time.to_i.days
		when "week-wise"
			time.to_i.weeks
		when "month-wise"
			time.to_i.months
		when "year-wise"
			time.to_i.years
		end
	end
end
