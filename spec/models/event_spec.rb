require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Event, type: :model do
  #fixtures :events		
  #pending "add some examples to (or delete) #{__FILE__}"

  context "validation on save" do
  	it "should require name" do
  		@event = FactoryGirl.build(:invalid_event)
  		@event.valid?  		
  		expect(@event.errors[:name].size).to eq(2)  		  		
  	end
  	it "should require job_name" do
  		@event = FactoryGirl.build(:invalid_event)
  		@event.valid?  		
  		expect(@event.errors[:job_name].size).to eq(2)  		  		
  	end
  	it "should require job_name" do
  		@event = FactoryGirl.build(:invalid_event)
  		@event.valid?  		
  		expect(@event.errors[:job_arguments].size).to eq(1)
  	end
  	it "should require start_at to be in future" do
  		@event = FactoryGirl.build(:invalid_event)
  		@event.valid?  		
  		expect(@event.errors[:start_date].size).to eq(1)
  	end
  end
end
