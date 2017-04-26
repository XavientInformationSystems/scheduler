class EventsController < ApplicationController
  include EventsHelper
  before_action :set_event, only: [:show, :edit, :update, :destroy, :start, :stop]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, success: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    #@event.status = "Pending"

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, success: 'Event was successfully rescheduled.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy    
    @event.destroy    
    respond_to do |format|
      format.html { redirect_to events_url, success: 'Event was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def start    
    if @event.start_at > DateTime.now
      if @event.occurrence.eql?("Once")
        create_event_results(@event, @event.start_at)        
      else
        @event.execution_time.each do |time|
          if !time.eql?("")
            @time = @event.start_at + get_execution_time(time, @event.frequency)
            create_event_results(@event, @time)            
          end
        end        
      end      
      

      flash[:success] = "Event Scheduled."
    else
      flash[:alert] = "Start At time is passed, please reshedule for future time."
    end
    redirect_to("/")
  end

  def stop
    @event_results = @event.event_results.where(:job_id => @event.job_id).limit(1)

    unless @event_results.nil? and @event_results.status.eql?("Processed")
      @job = Delayed::Job.find(@event.job_id)
      @job.delete
      @event_results.update_attributes(status: "Pending")

      flash[:success] = "Event removed from queue."
    else
      flash[:alert] = "Event has already been processed, can't be removed."
    end
    redirect_to("/")
  end

  private

    def create_event_results(event, time)      
      @job = Delayed::Job.enqueue EventJob.new(event), :run_at => time
      event.update_attributes(job_id: @job.id)
      @event_results = event.event_results.where(:job_id => event.job_id).limit(1)

      if @event_results.blank?
        event.event_results.create(job_id: event.job_id, queue: @job.queue, 
          priority: @job.priority, run_at: @job.run_at, attempts: @job.attempts, status: "Enqueued")
      else
        @event_results.update_attributes(priority: event.priority, run_at: event.start_at, status: "Enqueued")     
      end            
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :occurrence, :job_name, :job_arguments, :start_at,
                                    :priority, :frequency, :execution_time => [])
    end
end
