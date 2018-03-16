class LectureModulesController < ApplicationController
  before_action :set_lecture_module, only: [:show, :edit, :update, :destroy]
  before_action :set_page_title_for_specific_module, only: [:show, :edit]

  # GET /lecture_modules
  # GET /lecture_modules.json
  def index
    @page_title = "Lecture Modules"
    set_module_collections
  end

  def add_to_my_modules
    module_to_add = LectureModule.find(params[:id])
    user_module_linker = UserModuleLinker.add_new_linker(module_to_add, current_user)


    respond_to do |format|
      if user_module_linker.save
        set_module_collections
        format.html { redirect_back fallback_location: root_path, notice: 'Lecture module was successfully added to My Modules.' }
        format.js
        format.json { head :ok }
      else
        format.html { redirect_back fallback_location: root_path, notice: 'Lecture module could not be added to My Modules.' }
        format.json { head :ok }
      end
    end
  end

  def remove_from_my_modules
    module_to_remove = LectureModule.find(params[:id])
    user_module_linker = UserModuleLinker.remove_linker(module_to_remove, current_user)

    set_module_collections
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Lecture module was successfully removed from My Modules.' }
      format.js
      format.json { head :no_content }
    end
  end

  # GET /lecture_modules/1
  # GET /lecture_modules/1.json
  def show
    @module_content = LectureModuleContent.get_content_for_module(@lecture_module)
    @weekly_content = Array.new(12)
    for i in 1..12 do
      @weekly_content[i] = LectureModuleContent.get_content_for_module_and_week(@lecture_module, i)
    end
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
                                        semester: semester)
  end

  # GET /lecture_modules/1/edit
  def edit
  end

  # POST /lecture_modules
  # POST /lecture_modules.json
  def create
    @lecture_module = LectureModule.new(lecture_module_params)

    respond_to do |format|
      if @lecture_module.save
        format.html { redirect_to @lecture_module, notice: 'Lecture module was successfully created.' }
        format.json { render :show, status: :created, location: @lecture_module }
      else
        format.html { render :new }
        format.json { render json: @lecture_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lecture_modules/1
  # PATCH/PUT /lecture_modules/1.json
  def update
    respond_to do |format|
      if @lecture_module.update(lecture_module_params)
        format.html { redirect_to @lecture_module, notice: 'Lecture module was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture_module }
      else
        format.html { render :edit }
        format.json { render json: @lecture_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lecture_modules/1
  # DELETE /lecture_modules/1.json
  def destroy
    @lecture_module.destroy
    respond_to do |format|
      format.html { redirect_to lecture_modules_url, notice: 'Lecture module was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture_module
      @lecture_module = LectureModule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_module_params
      params.require(:lecture_module).permit(:code, :academic_year_end, :semester, :name)
    end

    def set_page_title_for_specific_module
      @page_title = @lecture_module.get_module_full_title
    end

    def set_module_collections
      @my_current_modules = LectureModule.get_my_current_modules(current_user)
      @my_completed_modules = LectureModule.get_my_completed_modules(current_user)
      @all_current_modules = LectureModule.current
      @all_completed_modules = LectureModule.completed
    end

end
