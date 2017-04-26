require 'rails_helper'

RSpec.describe EventResult, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  context "validation on save" do  	
  	it "should require start_at to be in future" do
  		@event = FactoryGirl.build(:invalid_event_result)
  		@event.valid?  		
  		expect(@event.errors[:run_at].size).to eq(1)
  	end
  end
end
