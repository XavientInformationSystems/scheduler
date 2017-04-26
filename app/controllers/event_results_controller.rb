class EventResultsController < ApplicationController
  before_action :set_event_result, only: [:edit, :update, :destroy, :stop, :start]

  # GET /event_results/1/edit
  def edit
  end

  
  # PATCH/PUT /event_results/1
  # PATCH/PUT /event_results/1.json
  def update
    @event_result.status = "Scheduled"
    respond_to do |format|
      if @event_result.update(event_result_params)
        format.html { redirect_to @event_result.event, success: 'Sub Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_result }
      else
        format.html { render :edit }
        format.json { render json: @event_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_results/1
  # DELETE /event_results/1.json
  def destroy
    @event_result.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event_result.event), success: 'Sub Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def start    
    if @event_result.run_at > DateTime.now
      begin
        @job = Delayed::Job.find(@event_result.job_id)
        unless @job.nil?          
          @job.invoke_job
        end
      rescue ActiveRecord::RecordNotFound
        
      end
      @job = Delayed::Job.enqueue EventJob.new(@event_result.event), :run_at => @event_result.run_at
      @event_result.status = "Enqueued"
      @event_result.job_id = @job.id
      @event_result.save(:validate => false)
      
      flash[:success] = "Event Scheduled."
    else
      flash[:alert] = "Run At time is passed, please reshedule for future time."
    end
    redirect_to event_path(@event_result.event)
  end

  def stop
    unless @event_result.nil? and @event_result.status.eql?("Processed")
      begin 
        @job = Delayed::Job.find(@event_result.job_id)
        unless @job.nil?
          @job.delete
        end
      rescue ActiveRecord::RecordNotFound
        
      end      
      @event_result.status = "Pending"
      @event_result.job_id = ""
      @event_result.save(:validate => false)

      flash[:success] = "Sub Event removed from queue."
    else
      flash[:alert] = "Sub Event has already been processed, can't be removed."
    end
    redirect_to event_path(@event_result.event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_result
      @event_result = EventResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_result_params
      params.require(:event_result).permit(:run_at, :priority, :attempts, :last_error, :failed_at,
                                         :status, :event_id, :job_id, :queue)
    end
end
