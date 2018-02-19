class LectureModulesController < ApplicationController
  before_action :set_lecture_module, only: [:show, :edit, :update, :destroy]
  before_action :set_page_title_for_specific_module, only: [:show, :edit, :update]

  # GET /lecture_modules
  # GET /lecture_modules.json
  def index
    @page_title = "Lecture Modules"
    @lecture_modules = LectureModule.all
    @current_modules = LectureModule.current
    @completed_modules = LectureModule.completed
    me = current_user
    puts User.find(me.id).email
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
      @page_title = "#{@lecture_module.code} - #{@lecture_module.name}"
    end

end
