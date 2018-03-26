# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# LectureModuleContent.delete_all
# LectureModule.delete_all

user_ian = User.find_by(username: 'aca15iw')

LectureModule.first_or_create!(user_id: user_ian,
                               code: 'COM3501',
                               academic_year_end: 2018,
                               semester: 'Spring',
                               name: "Computer Security and Forensics")

LectureModule.first_or_create!(user_id: user_ian,
                               code: 'COM3503',
                               academic_year_end: 2018,
                               semester: 'Autumn',
                               name: "3D Computer Graphics")

LectureModule.first_or_create!(user_id: user_ian,
                               code: 'COM2002',
                               academic_year_end: 2017,
                               semester: 'Autumn',
                               name: "Human Centered Systems Design")

LectureModule.first_or_create!(user_id: user_ian,
                               code: 'COM1001',
                               academic_year_end: 2016,
                               semester: 'Academic Year',
                               name: "Introduction to Software Engineering")

module_id = LectureModule.find_by(code: 'COM3501', academic_year_end: 2018)

content_path_1 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_1_1.pdf"
content_file_1 = File.open(content_path_1)
LectureModuleContent.create!(week: 1,
                             description: '1.1',
                             lecture_module_id: module_id.id,
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file_1),
                               tempfile: content_file_1,
                               type: MIME::Types.type_for(content_path_1).first.content_type
                               )
                             )

content_path_2 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_1_2.pdf"
content_file_2 = File.open(content_path_2)
LectureModuleContent.create!(week: 1,
                            description: '1.2',
                            lecture_module_id: module_id.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file_2),
                              tempfile: content_file_2,
                              type: MIME::Types.type_for(content_path_2).first.content_type
                              )
                            )

content_path_3 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_1_3.pdf"
content_file_3 = File.open(content_path_3)
LectureModuleContent.create!(week: 1,
                             description: '1.3',
                             lecture_module_id: module_id.id,
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file_3),
                               tempfile: content_file_3,
                               type: MIME::Types.type_for(content_path_3).first.content_type
                               )
                             )

content_path_4 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_2.pdf"
content_file_4 = File.open(content_path_4)
LectureModuleContent.create!(week: 2,
                            description: '2',
                            lecture_module_id: module_id.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file_4),
                              tempfile: content_file_4,
                              type: MIME::Types.type_for(content_path_4).first.content_type
                              )
                            )
content_path_5 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_3_1.pdf"
content_file_5 = File.open(content_path_5)
LectureModuleContent.create!(week: 3,
                             description: '3.1',
                             lecture_module_id: module_id.id,
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file_5),
                               tempfile: content_file_5,
                               type: MIME::Types.type_for(content_path_5).first.content_type
                               )
                             )

content_path_6 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_3_2.pdf"
content_file_6 = File.open(content_path_6)
LectureModuleContent.create!(week: 3,
                            description: '3.2',
                            lecture_module_id: module_id.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file_6),
                              tempfile: content_file_6,
                              type: MIME::Types.type_for(content_path_6).first.content_type
                              )
                            )
content_path_7 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_4.pdf"
content_file_7 = File.open(content_path_7)
LectureModuleContent.create!(week: 4,
                             description: '4',
                             lecture_module_id: module_id.id,
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file_7),
                               tempfile: content_file_7,
                               type: MIME::Types.type_for(content_path_7).first.content_type
                               )
                             )

content_path_8 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_5.pdf"
content_file_8 = File.open(content_path_8)
LectureModuleContent.create!(week: 5,
                            description: '5',
                            lecture_module_id: module_id.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file_8),
                              tempfile: content_file_8,
                              type: MIME::Types.type_for(content_path_8).first.content_type
                              )
                            )

content_path_9 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_6.pdf"
content_file_9 = File.open(content_path_9)
LectureModuleContent.create!(week: 6,
                             description: '6',
                             lecture_module_id: module_id.id,
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file_9),
                               tempfile: content_file_9,
                               type: MIME::Types.type_for(content_path_9).first.content_type
                               )
                             )

content_path_10 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_7.pdf"
content_file_10 = File.open(content_path_10)
LectureModuleContent.create!(week: 7,
                            description: '7',
                            lecture_module_id: module_id.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file_10),
                              tempfile: content_file_10,
                              type: MIME::Types.type_for(content_path_10).first.content_type
                              )
                            )




#
#
# image_path = "#{Rails.root}/path/to/image_file.extension"
# image_file = File.new(image_path)
#
# Image.create(
#   :id => 52,
#   :product_id => 52,
#   :asset => ActionDispatch::Http::UploadedFile.new(
#     :filename => File.basename(image_file),
#     :tempfile => image_file,
#     # detect the image's mime type with MIME if you can't provide it yourself.
#     :type => MIME::Types.type_for(image_path).first.content_type
#   )
# )
