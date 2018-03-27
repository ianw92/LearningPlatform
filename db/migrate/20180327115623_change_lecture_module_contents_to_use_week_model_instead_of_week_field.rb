class ChangeLectureModuleContentsToUseWeekModelInsteadOfWeekField < ActiveRecord::Migration[5.1]
  def change
    # for each module, create 12 week models
    LectureModule.all.each do |lecture_module|
      for i in 1..12 do
        Week.create(lecture_module_id: lecture_module,
                    week_number: i)
      end
    end

    # for each lecture module contents, add reference to correct week record.
    LectureModuleContent.all.each do |lecture_module_content|
      lec_mod_id = lecture_module_content.lecture_module_id
      week = lecture_module_content.week
      week_record = Week.find_by(lecture_module_id: lec_mod_id, week_number: week)

      LectureModuleContent.update(lecture_module_content.id, week_id: week_record)
    end

    # then remove lecture_module_id reference and week field
    remove_reference :lecture_module_contents, :lecture_module, index: true, foreign_key: true
    remove_column :lecture_module_contents, :week
  end
end
