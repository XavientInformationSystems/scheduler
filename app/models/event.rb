# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  occurrence     :string(255)
#  start_at       :datetime
#  job_name       :string(255)
#  job_arguments  :json
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  priority       :integer          default("10")
#  job_id         :integer
#  frequency      :string(255)      default("")
#  execution_time :text(65535)
#

class Event < ApplicationRecord

	serialize :execution_time, Array

	has_many :event_results, dependent: :destroy

	validates :name, :job_name, :job_arguments, :presence => true
	validates :name, :job_name, length: { in: 6..20 }
	validates :start_at, with: :start_at_is_not_past_time

	def start_at_is_not_past_time
		if self.start_at > DateTime.now
			true
		else
			errors.add(:start_date, "date should be in the future.")
			false
		end
	end	

	def self.start_job command
	 	system command
	end	
end
