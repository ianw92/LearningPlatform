class LectureModuleContent < ApplicationRecord
  belongs_to :week
  has_attached_file :content

  validates_attachment :content, content_type: {content_type: ["application/pdf"]}
  validate :content_xor_youtube_must_exist
  validates_format_of :youTube_link, with: /\A(https:\/\/www.youtube.com\/embed\/[A-Za-z0-9_]*)*\z/i, on: [:create, :update]

  ########## Validation methods

  def content_xor_youtube_must_exist
    if content.blank? && youTube_link.blank?
      errors.add(:base, "Lecture Module Content must have either a pdf file or a youTube link")
    end
    if !content.blank? && !youTube_link.blank?
      errors.add(:base, "Lecture Module Content cannot have both a pdf file and a youTube link")
    end
  end

  ########## Model methods

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

  def title
    title = ""
    if description?
      title += "#{description} | "
    end
    if content?
      title += "#{content_file_name}"
    else
      title += "#{youTube_link}"
    end
  end

  def s3_url
    stored_url = content.url
    stored_url.sub! 'amazonaws', 'eu-west-2.amazonaws'
  end


end
