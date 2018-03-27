class LectureModuleContentsController < ApplicationController
  before_action :set_lecture_module_content, only: [:show, :edit, :update, :destroy]
  before_action :set_page_title_for_specific_content, only: [:show, :edit, :update]
  authorize_resource

  # GET /lecture_module_contents
  # GET /lecture_module_contents.json
  def index
    @page_title = "All Module Content"
    @lecture_module_contents = LectureModuleContent.all.order(:code, :academic_year_end, :week)
  end

  # GET /lecture_module_contents/1
  # GET /lecture_module_contents/1.json
  def show
  end

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
  end

  # POST /lecture_module_contents
  # POST /lecture_module_contents.json
  def create
    @lecture_module_content = LectureModuleContent.new(lecture_module_content_params)

    respond_to do |format|
      if @lecture_module_content.save
        format.html { redirect_to lecture_module_path(@lecture_module_content.lecture_module_id), notice: 'Lecture module content was successfully created.' }
        format.json { render :show, status: :created, location: @lecture_module_content }
      else
        format.html { render :new }
        format.json { render json: @lecture_module_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lecture_module_contents/1
  # PATCH/PUT /lecture_module_contents/1.json
  def update
    respond_to do |format|
      if @lecture_module_content.update(lecture_module_content_params)
        format.html { redirect_to lecture_module_path(@lecture_module_content.lecture_module_id), notice: 'Lecture module content was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture_module_content }
      else
        format.html { render :edit }
        format.json { render json: @lecture_module_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lecture_module_contents/1
  # DELETE /lecture_module_contents/1.json
  def destroy
    @lecture_module_content.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Lecture module content was successfully destroyed.' }
      format.json { head :no_content }
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
