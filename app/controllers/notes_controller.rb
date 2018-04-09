class NotesController < ApplicationController
  before_action :set_note, only: [:update, :destroy]
  authorize_resource

  def show_notes_toggle
    @week_id = params[:week_id]
    lecture_module = Week.find(@week_id).lecture_module
    @weeks = lecture_module.weeks
    profile = Profile.find_by(user_id: current_user.id)
    profile = profile.change_show_notes_state
    respond_to do |format|
      if profile.save
        format.html { redirect_back fallback_location: root_path, notice: 'Profile was successfully updated.' }
        format.js
      else
        format.html { redirect_back fallback_location: root_path, notice: 'Profile could not be updated.' }
      end
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_back fallback_location: root_path, notice: 'Note was successfully created.' }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    if params[:note][:body].empty?
      return destroy
    else
      respond_to do |format|
        if @note.update(note_params)
          format.html { redirect_back fallback_location: root_path, notice: 'Note was successfully updated.' }
          format.js
        else
          format.html { redirect_back fallback_location: root_path, alert: 'Note could not be updated.' }
        end
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @week = @note.week
    @note.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Note was successfully destroyed.' }
      format.js { render :template => 'notes/destroy.js.erb' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:user_id, :week_id, :body)
    end
end
