# == Schema Information
#
# Table name: event_results
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  job_id     :string(255)
#  queue      :string(255)
#  attempts   :integer
#  last_error :text(65535)
#  priority   :integer
#  locked_by  :text(65535)
#  run_at     :datetime
#  failed_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string(255)      default("Pending")
#

class EventResult < ApplicationRecord
	belongs_to :event

	validates :run_at, with: :run_at_is_not_past_time

	def run_at_is_not_past_time
		if self.run_at > DateTime.now
			true
		else
			errors.add(:run_at, "date should be in the future.")
			false
		end
	end	

end
