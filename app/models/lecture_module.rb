class LectureModule < ApplicationRecord
  has_many :user_module_linkers, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :users, :through => :user_module_linkers
  belongs_to :user
  has_many :lecture_module_contents, dependent: :destroy

  validates :code, :academic_year_end, :semester, :name, presence: true
  validates :code, length: { in: 5..20 }
  validates :academic_year_end, numericality: true,
                                inclusion: { within: 2000..2100 }
  validates :semester, numericality: true,
                       inclusion: { in: 0..2 }
  validates :name, length: { in: 5..50 }
  validates :code, uniqueness: { scope: :academic_year_end, message: 'Code/AcademicYear pair must be unique' }

  after_create :create_user_module_linker

  def create_user_module_linker
    UserModuleLinker.create(lecture_module: self, user: self.user)
  end

  # Change semester input from a string to an integer representing that string
  def semester=(val)
    write_attribute(:semester, process_semester(val))
  end

  def process_semester(semester_as_text)
    case semester_as_text
    when "Academic Year"
      return 0
    when "Autumn"
      return 1
    when "Spring"
      return 2
    end
  end


  # TODO this method should only be called once, not in both self.get_other_current_modules
  # and self.get_other_completed_modules, how do I do this??
  def self.set_current_year_and_semester
    time = Time.now
    current_year = time.year
    current_month = time.month
    current_month > 8 ? @current_year_end = current_year + 1 : @current_year_end = current_year
    current_month > 1 && current_month < 9 ? @current_semester = 2 : @current_semester = 1
  end

  #TODO test this
  def get_module_full_title
    "#{code} - #{name} -
     #{"ACADEMIC YEAR" if semester == 0}#{"AUTUMN" if semester == 1}#{"SPRING" if semester == 2}
     #{academic_year_end - 1}/#{academic_year_end}"
   end

   # My modules
   #TODO test this
   def self.get_my_current_modules(user)
     self.set_current_year_and_semester
     user_id = user.id
     my_module_linkers = UserModuleLinker.where("user_id = ?", user_id)
     my_module_ids = my_module_linkers.pluck(:lecture_module_id)
     LectureModule.where(id: my_module_ids).where("academic_year_end = ?", @current_year_end).where("semester = 0 OR semester = ?", @current_semester)
   end

   #TODO test this
   def self.get_my_completed_modules(user)
     self.set_current_year_and_semester
     user_id = user.id
     my_module_linkers = UserModuleLinker.where("user_id = ?", user_id)
     my_module_ids = my_module_linkers.pluck(:lecture_module_id)
     if @current_semester == 1
       LectureModule.where(id: my_module_ids).where("academic_year_end != ?", @current_year_end).order(:code)
     else
       LectureModule.where(id: my_module_ids).where("academic_year_end != ? OR academic_year_end = ? AND semester = 1", @current_year_end, @current_year_end).order(:code)
     end
   end

   # Other modules
   def self.get_other_current_modules(user)
     self.set_current_year_and_semester

     user_id = user.id
     my_module_linkers = UserModuleLinker.where("user_id = ?", user_id)
     my_module_ids = my_module_linkers.pluck(:lecture_module_id)

     current = LectureModule.where("academic_year_end = ?", @current_year_end).where("semester = 0 OR semester = ?", @current_semester).where.not(id: my_module_ids)
     current.order(:code)
   end

   def self.get_other_completed_modules(user)
     self.set_current_year_and_semester

     user_id = user.id
     my_module_linkers = UserModuleLinker.where("user_id = ?", user_id)
     my_module_ids = my_module_linkers.pluck(:lecture_module_id)

     if @current_semester == 1
       completed = LectureModule.all(:conditions => ["academic_year_end != ?", @current_year_end]).where.not(id: my_module_ids)
     else
       completed = LectureModule.where("academic_year_end != ? OR academic_year_end = ? AND semester = 1", @current_year_end, @current_year_end).where.not(id: my_module_ids)
     end
     completed.order(:code)
   end

end
