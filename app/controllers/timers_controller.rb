class TimersController < ApplicationController
  before_action :set_timer, only: [:update]
  authorize_resource

  # PATCH/PUT /timers/1
  # PATCH/PUT /timers/1.json
  def update
    respond_to do |format|
      if @timer.update(timer_params)
        format.html { redirect_back fallback_location: root_path, notice: 'Timer was successfully updated.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timer
      @timer = Timer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timer_params
      params.require(:timer).permit(:user_id, :study_length, :short_break_length, :long_break_length)
    end
end
