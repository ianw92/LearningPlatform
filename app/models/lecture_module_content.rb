class LectureModuleContent < ApplicationRecord
  belongs_to :week
  has_attached_file :content

  validates_attachment :content, content_type: {content_type: ["application/pdf"]}
  validate :content_xor_youtube_must_exist

  ########## Validation methods

  def content_xor_youtube_must_exist
    if content.blank? && youTube_link.blank?
      errors.add(:base, "Lecture Module Content must have either pdf file or a youTube link")
    end
  end

  ########## Model methods
  # Returns all module content for given module, ordered by week
  def self.get_content_for_module(lecture_module)
    code = lecture_module.code
    academic_year_end = lecture_module.academic_year_end
    LectureModuleContent.where(lecture_module_id: lecture_module).order(:week)
  end

  #TODO test this
  def self.get_content_for_module_and_week(lecture_module, week)
    code = lecture_module.code
    academic_year_end = lecture_module.academic_year_end
    LectureModuleContent.where(lecture_module_id: lecture_module)
                        .where("week = ?", week)
  end

  def get_module_code
    LectureModule.find(lecture_module_id).code
  end

  def get_module_name
    LectureModule.find(lecture_module_id).name
  end

  def get_module_full_title
    week = Week.find(week_id)
    LectureModule.where(id: week.lecture_module_id).first.get_module_full_title
  end

  def week_number
    week = Week.find(week_id)
    week.week_number
  end

  def lecture_module_id
    week = Week.find(week_id)
    week.lecture_module_id
  end


end
