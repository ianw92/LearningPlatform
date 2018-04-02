class LectureModule < ApplicationRecord
  has_many :user_module_linkers, dependent: :destroy
  has_many :users, :through => :user_module_linkers
  belongs_to :user
  has_many :weeks, dependent: :destroy

  validates :code, :academic_year_end, :semester, :name, presence: true
  validates :code, length: { in: 5..20 }
  validates :academic_year_end, numericality: { greater_than_or_equal_to: Date.today.year - 5,
                                                less_than_or_equal_to: Date.today.year + 1 }
  validates :semester, inclusion: { in: 0..2 }
  validates :name, length: { in: 5..50 }
  validates :code, uniqueness: { scope: :academic_year_end, message: 'Code/AcademicYear pair must be unique' }

  after_create :create_user_module_linker
  after_create :create_weeks_for_module
  around_destroy :delete_assosciated_user_module_linkers

  def create_user_module_linker
    UserModuleLinker.create(lecture_module: self, user: self.user)
  end

  def create_weeks_for_module
    for i in 1..12 do
      Week.create(lecture_module: self, week_number: i)
    end
  end

  def delete_assosciated_user_module_linkers
    lecture_module_id = self.id
    yield
    UserModuleLinker.where(lecture_module_id: lecture_module_id)
  end

  # Change semester input from a string to an integer representing that string
  def semester=(val)
    write_attribute(:semester, LectureModule.process_semester(val))
  end

  def self.process_semester(semester_as_text)
    case semester_as_text
    when "Academic Year"
      return 0
    when "Autumn"
      return 1
    when "Spring"
      return 2
    end
  end

  ############

  def get_module_full_title
    "#{code} - #{name} - #{self.semester_as_string} #{self.academic_year_string}"
  end

   def semester_as_string
     if semester == 0
       return "ACADEMIC YEAR"
     elsif semester == 1
       return "AUTUMN"
     elsif semester == 2
       return "SPRING"
     end
   end

   def academic_year_string
     year_start = academic_year_end - 1
     return "#{year_start}/#{academic_year_end}"
   end

   #########
   # Methods to get current/completed modules

   def self.set_current_year_and_semester
     time = Time.now
     current_year = time.year
     current_month = time.month
     current_month > 8 ? current_year_end = current_year + 1 : current_year_end = current_year
     current_month > 1 && current_month < 9 ? current_semester = 2 : current_semester = 1
     return current_year_end, current_semester
   end

   # My modules
   # TODO make these into one method that returns 4 lists?
   # TODO And/or set current_year_end and current_semester using a before_action callback
   def self.get_my_current_modules(user)
     current_year_end, current_semester = self.set_current_year_and_semester
     my_module_ids = UserModuleLinker.where(user: user).pluck(:lecture_module_id)

     LectureModule.where(id: my_module_ids).where(academic_year_end: current_year_end).where("semester = 0 OR semester = ?", current_semester)
   end

   def self.get_my_completed_modules(user)
     current_year_end, current_semester = self.set_current_year_and_semester
     my_module_ids = UserModuleLinker.where(user: user).pluck(:lecture_module_id)

     if current_semester == 1
       LectureModule.where(id: my_module_ids).where.not(academic_year_end: current_year_end).order(:code)
     else
       LectureModule.where(id: my_module_ids).where("academic_year_end != ? OR academic_year_end = ? AND semester = 1", current_year_end, current_year_end).order(:code)
     end
   end

   # Other modules
   def self.get_other_current_modules(user)
     current_year_end, current_semester = self.set_current_year_and_semester
     my_module_ids = UserModuleLinker.where(user: user).pluck(:lecture_module_id)
     other_module_ids = self.where.not(id: my_module_ids).ids

     current = LectureModule.where(id: other_module_ids).where(academic_year_end: current_year_end).where("semester = 0 OR semester = ?", current_semester)
     current.order(:code)
   end

   def self.get_other_completed_modules(user)
     current_year_end, current_semester = self.set_current_year_and_semester
     my_module_ids = UserModuleLinker.where(user: user).pluck(:lecture_module_id)
     other_module_ids = self.where.not(id: my_module_ids).ids

     if current_semester == 1
       completed = LectureModule.where(id: other_module_ids).where.not(academic_year_end: current_year_end)
     else
       completed = LectureModule.where(id: other_module_ids).where("academic_year_end != ? OR academic_year_end = ? AND semester = 1", current_year_end, current_year_end).where(id: other_module_ids)
     end
     completed.order(:code)
   end

end
