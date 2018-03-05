class LectureModuleContent < ApplicationRecord
  belongs_to :lecture_module
  has_attached_file :content

  validates :code, :academic_year_end, :week, presence: true
  validates :code, length: { in: 5..20 }
  validates :academic_year_end, numericality: true,
                                inclusion: { within: 2000..2100 }
  validates :week, numericality: true,
                   inclusion: { within: 1..12 }
  validates_attachment :content, content_type: {content_type: ["application/pdf"]}
  validate :module_must_exist, :module_id_must_match_code_and_year
  validate :content_description_or_youtube_must_exist

  ########## Validation methods

  def content_description_or_youtube_must_exist
    if content.blank? && youTube_link.blank? && description.blank?
      errors.add(:base, "Lecture Module Content must have at least one of: content; youTube link; or description")
    end
  end

  # TODO do I need both of these two methods or will the bottom one only suffice?
  def module_must_exist
    if LectureModule.where("code = ?", code).where("academic_year_end = ?", academic_year_end).blank?
      errors.add(:code, "and academic year end pair must exist")
    end
  end

  def module_id_must_match_code_and_year
    if LectureModule.where("code = ?", code)
                    .where("academic_year_end = ?", academic_year_end)
                    .where("id = ?", lecture_module_id).blank?
      errors.add(:lecture_module_id, "doesn't match code and academic year end")
    end
  end

  ########## Model methods
  # Returns all module content for given module, ordered by week
  def self.get_content_for_module(lecture_module)
    code = lecture_module.code
    academic_year_end = lecture_module.academic_year_end
    LectureModuleContent.where("code = ?", code)
                        .where("academic_year_end = ?", academic_year_end).order(:week)
  end

  #TODO test thiss
  def self.get_content_for_module_and_week(lecture_module, week)
    code = lecture_module.code
    academic_year_end = lecture_module.academic_year_end
    LectureModuleContent.where("code = ?", code)
                        .where("academic_year_end = ?", academic_year_end)
                        .where("week = ?", week)
  end


end
