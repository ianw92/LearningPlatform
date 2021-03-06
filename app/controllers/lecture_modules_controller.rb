class LectureModulesController < ApplicationController
  before_action :set_lecture_module, only: [:show, :edit, :update, :destroy]
  before_action :set_page_title_for_specific_module, only: [:show, :edit]
  authorize_resource

  # GET /lecture_modules
  # GET /lecture_modules.json
  def index
    @page_title = "Lecture Modules"
    set_module_collections
  end

  def add_to_my_modules
    module_to_add = LectureModule.find(params[:id])
    user_module_linker = UserModuleLinker.add_new_linker(module_to_add, current_user)
    user_module_linker.save

    set_module_collections
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Lecture Module was successfully added to My Modules.' }
      format.js
    end
  end

  def remove_from_my_modules
    module_to_remove = LectureModule.find(params[:id])
    user_module_linker = UserModuleLinker.remove_linker(module_to_remove, current_user)

    set_module_collections
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Lecture Module was successfully removed from My Modules.' }
      format.js
    end
  end

  # GET /lecture_modules/1
  # GET /lecture_modules/1.json
  def show
    if !session[:open_week_number].nil?
      @open_week_number = session[:open_week_number]
      session[:open_week_number] = nil
    end

    @weeks = @lecture_module.weeks
    @weekly_content = Array.new(12)
    for i in 0..@weeks.length-1 do
      @weekly_content[i] = @weeks[i].lecture_module_contents
    end

    @notes = Note.get_notes_for_module_and_user(@lecture_module, current_user)
    @weeks_with_notes = @notes.pluck(:week_id).map { |week_id| week_id % 12 }
  end

  # GET /lecture_modules/new
  def new
    @page_title = "New Lecture Module"
    time = Time.now
    year = time.year
    month = time.month
    semester = 0
    month > 1 && month < 10 ? semester = 1 : semester = 2
    @lecture_module = LectureModule.new(academic_year_end: year,
                                        semester: semester,
                                        user_id: current_user.id)
  end

  # GET /lecture_modules/1/edit
  def edit
    # Set params for semester so that select form will pre-select the correct option
    params[:semester] = @lecture_module.semester_as_string.titlecase
  end

  # POST /lecture_modules
  # POST /lecture_modules.json
  def create
    @lecture_module = LectureModule.new(lecture_module_params)

    respond_to do |format|
      if @lecture_module.save
        format.html { redirect_to @lecture_module, notice: 'Lecture Module was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /lecture_modules/1
  # PATCH/PUT /lecture_modules/1.json
  def update
    respond_to do |format|
      if @lecture_module.update(lecture_module_params)
        format.html { redirect_to @lecture_module, notice: 'Lecture Module was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /lecture_modules/1
  # DELETE /lecture_modules/1.json
  def destroy
    @lecture_module.destroy
    respond_to do |format|
      format.html { redirect_to lecture_modules_url, notice: 'Lecture Module was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture_module
      @lecture_module = LectureModule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_module_params
      params.require(:lecture_module).permit(:code, :academic_year_end, :semester, :name, :user_id)
    end

    def set_page_title_for_specific_module
      @page_title = @lecture_module.get_module_full_title
    end

    def set_module_collections
      @my_current_modules = LectureModule.get_my_current_modules(current_user)
      @my_completed_modules = LectureModule.get_my_completed_modules(current_user)
      @all_current_modules = LectureModule.get_other_current_modules(current_user)
      @all_completed_modules = LectureModule.get_other_completed_modules(current_user)
    end

end
