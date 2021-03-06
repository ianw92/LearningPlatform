class LectureModuleContentsController < ApplicationController
  before_action :set_lecture_module_content, only: [:edit, :update, :destroy]
  before_action :set_page_title_for_specific_content, only: [:edit, :update]
  authorize_resource

  # GET /lecture_module_contents/new
  def new
    if !params[:week].nil?
      week = Week.find(params[:week])
      @lecture_module_content = LectureModuleContent.new(week_id: week.id)
    else
      redirect_back fallback_location: root_path, alert: 'This URL cannot be accessed directly.'
    end

  end

  # GET /lecture_module_contents/1/edit
  def edit
    session[:open_week_number] = @lecture_module_content.week.week_number
  end

  # POST /lecture_module_contents
  # POST /lecture_module_contents.json
  def create
    @lecture_module_content = LectureModuleContent.new(lecture_module_content_params)

    respond_to do |format|
      if @lecture_module_content.save
        session[:open_week_number] = @lecture_module_content.week.week_number
        format.html { redirect_to lecture_module_path(@lecture_module_content.lecture_module_id), notice: 'Lecture Module Content was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /lecture_module_contents/1
  # PATCH/PUT /lecture_module_contents/1.json
  def update
    respond_to do |format|
      if @lecture_module_content.update(lecture_module_content_params)
        session[:open_week_number] = @lecture_module_content.week.week_number
        format.html { redirect_to lecture_module_path(@lecture_module_content.lecture_module_id), notice: 'Lecture Module Content was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /lecture_module_contents/1
  # DELETE /lecture_module_contents/1.json
  def destroy
    session[:open_week_number] = @lecture_module_content.week.week_number
    @lecture_module_content.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Lecture Module Content was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture_module_content
      @lecture_module_content = LectureModuleContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_module_content_params
      params.require(:lecture_module_content).permit(:week_id, :description, :content, :youTube_link)
    end

    def set_page_title_for_specific_content
      @page_title = @lecture_module_content.get_module_full_title
    end
end
