class LectureModule < ApplicationRecord
  has_many :lecture_module_contents

  validates :code, :academic_year_end, :semester, :name, presence: true
  validates :code, length: { in: 5..20 }
  validates :academic_year_end, numericality: true,
                                inclusion: { within: 2000..2100 }
  validates :semester, numericality: true,
                       inclusion: { in: 0..2 }
  validates :name, length: { in: 5..50 }
  validates :code, uniqueness: { scope: :academic_year_end, message: 'Code/AcademicYear pair must be unique' }

  def self.current
    self.set_current_year_and_semester
    current = LectureModule.where("academic_year_end = ?", @current_year_end).where("semester = 0 OR semester = ?", @current_semester)
    current.order(:code)
  end

  def self.completed
    self.set_current_year_and_semester
    if @current_semester == 1
      completed = LectureModule.all(:conditions => ["academic_year_end != ?", @current_year_end])
    else
      completed = LectureModule.where("academic_year_end != ? OR academic_year_end = ? AND semester = 1", @current_year_end, @current_year_end)
    end
    completed.order(:code)
  end

  # TODO this method should only be called once, not in both self.current
  # and self.completed, how do I do this??
  def self.set_current_year_and_semester
    time = Time.now
    current_year = time.year
    current_month = time.month
    current_month > 8 ? @current_year_end = current_year + 1 : @current_year_end = current_year
    current_month > 1 && current_month < 9 ? @current_semester = 2 : @current_semester = 1
  end

end
