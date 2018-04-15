# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

LectureModuleContent.delete_all
Comment.delete_all
Note.delete_all
Week.delete_all
LectureModule.delete_all


user_ian = User.find_by(username: 'aca15iw')

LectureModule.create!(user_id: user_ian.id,
                               code: 'COM3501',
                               academic_year_end: 2018,
                               semester: 'Spring',
                               name: "Computer Security and Forensics")

LectureModule.create!(user_id: user_ian.id,
                              code: 'COM3504',
                              academic_year_end: 2018,
                              semester: 'Spring',
                              name: "The Intelligent Web")

LectureModule.create!(user_id: user_ian.id,
                              code: 'COM3240',
                              academic_year_end: 2018,
                              semester: 'Spring',
                              name: "Adaptive Intelligence")

LectureModule.create!(user_id: user_ian.id,
                               code: 'COM3505',
                               academic_year_end: 2018,
                               semester: 'Autumn',
                               name: "The Internet of Things")

LectureModule.create!(user_id: user_ian.id,
                               code: 'MGT388',
                               academic_year_end: 2018,
                               semester: 'Autumn',
                               name: "Finance and Law for Engineers")

##########################################
# Create module content for COM3501 module
module_id = LectureModule.find_by(code: 'COM3501', academic_year_end: 2018)

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_1_1.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 1)
LectureModuleContent.create!(week_id: week.id,
                             description: 'Introduction',
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file),
                               tempfile: content_file,
                               type: MIME::Types.type_for(content_path).first.content_type
                               )
                             )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_1_2.pdf"
content_file = File.open(content_path)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Organisation',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_1_3.pdf"
content_file = File.open(content_path)
LectureModuleContent.create!(week_id: week.id,
                             description: 'Access Control',
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file),
                               tempfile: content_file,
                               type: MIME::Types.type_for(content_path).first.content_type
                               )
                             )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_2.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 2)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Cryptography',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )
content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_3_1.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 3)
LectureModuleContent.create!(week_id: week.id,
                             description: 'Crypto Attacks',
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file),
                               tempfile: content_file,
                               type: MIME::Types.type_for(content_path).first.content_type
                               )
                             )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_3_2.pdf"
content_file = File.open(content_path)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Signatures and PKIs',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )
content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_4.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 4)
LectureModuleContent.create!(week_id: week.id,
                             description: 'Security Protocols',
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file),
                               tempfile: content_file,
                               type: MIME::Types.type_for(content_path).first.content_type
                               )
                             )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_5.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 5)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Formal Analysis of Security Protocols',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_6.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 6)
LectureModuleContent.create!(week_id: week.id,
                             description: 'Application Security',
                             content: ActionDispatch::Http::UploadedFile.new(
                               filename: File.basename(content_file),
                               tempfile: content_file,
                               type: MIME::Types.type_for(content_path).first.content_type
                               )
                             )

content_path0 = "#{Rails.root}/public/system/lecture_module_contents/contents/com3501_week_7.pdf"
content_file0 = File.open(content_path0)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 7)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Threat Modelling',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file0),
                              tempfile: content_file0,
                              type: MIME::Types.type_for(content_path0).first.content_type
                              )
                            )


############################################
# Create module content for COM3504 module
module_id = LectureModule.find_by(code: 'COM3504', academic_year_end: 2018)

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3504_week_1.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 1)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Intro',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3504_week_2.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 2)
LectureModuleContent.create!(week_id: week.id,
                           description: 'NodeJS',
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3504_week_4.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 4)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Json, Ajax, Express',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3504_week_5.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 5)
LectureModuleContent.create!(week_id: week.id,
                           description: 'Progressive Apps',
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )
content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3504_week_7.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 7)
LectureModuleContent.create!(week_id: week.id,
                            description: 'MongoDB, Socket.io',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )


############################################
# Create module content for COM3240 module
module_id = LectureModule.find_by(code: 'COM3240', academic_year_end: 2018)

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3240_week_1.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 1)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Introduction to Supervised, Unsupervised and Reinforcement Leaning',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3240_week_2.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 2)
LectureModuleContent.create!(week_id: week.id,
                           description: 'Hebbian Learning, The BCM Rule and introduction to Oja’s rule',
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3240_week_3.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 3)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Oja’s rule. Principal Component Analysis (PCA)',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3240_week_5.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 5)
LectureModuleContent.create!(week_id: week.id,
                           description: 'Receptive Fields, Introduction to Competitive Learning',
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )
content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3240_week_7.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 7)
LectureModuleContent.create!(week_id: week.id,
                            description: 'More on Receptive fields and Competitive Learning',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )


############################################
# Create module content for COM3505 module
module_id = LectureModule.find_by(code: 'COM3505', academic_year_end: 2018)

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3505/1 - Click Here to Kill Everyone....pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 1)
LectureModuleContent.create!(week_id: week.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3505/2 - Revolutionary Code - From MIT Printers to the Arduino.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 2)
LectureModuleContent.create!(week_id: week.id,
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3505/3 - Small but Perfectly Formed... Digging into the ESP32.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 3)
LectureModuleContent.create!(week_id: week.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3505/4 - Sensing and Responding.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 4)
LectureModuleContent.create!(week_id: week.id,
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )
content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3505/5 - Cloudside.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 5)
LectureModuleContent.create!(week_id: week.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3505/6 - Networks - Joinme, WiFi, Sigfox, LoraWan and NB-IoT.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 6)
LectureModuleContent.create!(week_id: week.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/com3505/7 - Projects.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 7)
LectureModuleContent.create!(week_id: week.id,
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )


############################################
# Create module content for MGT388 module
module_id = LectureModule.find_by(code: 'MGT388', academic_year_end: 2018)

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/1 - Introduction.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 1)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/1 + 2 - Contract Lecture 1 & 2.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 1)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/2 - Overview of Financial Accounting.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 2)
LectureModuleContent.create!(week_id: week.id,
                           description: 'Finance',
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )


content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/3 - Ratio Analysis.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 3)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/3 - Contract Lecture 3.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 3)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/4 - Appraisal of Annual Reports Using ratio Analysis.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 4)
LectureModuleContent.create!(week_id: week.id,
                           description: 'Finance',
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/4 - IP Lecture 1.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 4)
LectureModuleContent.create!(week_id: week.id,
                           description: 'Law',
                           content: ActionDispatch::Http::UploadedFile.new(
                             filename: File.basename(content_file),
                             tempfile: content_file,
                             type: MIME::Types.type_for(content_path).first.content_type
                             )
                           )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/5 - Absorption Costing.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 5)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/5 - IP Lecture 2.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 5)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/6 - Pricing Decisions.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 6)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/6 - IP Lecture 3.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 6)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/7 - Marginal Costing and Short Term Decision Making.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 7)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/7 - Tort Lecture 1.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 7)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/8 - Break-Even Point.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 8)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/8 - Tort Lecture 2.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 8)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/9 - Capital Investment Appraisal.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 9)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/9 - Env Law Lecture 1.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 9)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Finance/10 - Financing.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 10)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Finance',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )

content_path = "#{Rails.root}/public/system/lecture_module_contents/contents/mgt388/Law/10 - Env Law Lecture 2.pdf"
content_file = File.open(content_path)
week = Week.find_by(lecture_module_id: module_id.id, week_number: 10)
LectureModuleContent.create!(week_id: week.id,
                            description: 'Law',
                            content: ActionDispatch::Http::UploadedFile.new(
                              filename: File.basename(content_file),
                              tempfile: content_file,
                              type: MIME::Types.type_for(content_path).first.content_type
                              )
                            )
