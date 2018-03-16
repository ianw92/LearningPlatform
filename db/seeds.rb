# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

LectureModuleContent.delete_all
LectureModule.delete_all

LectureModule.create!(code: 'COM3501',
                      academic_year_end: 2018,
                      semester: 2,
                      name: "Computer Security and Forensics")

LectureModule.create!(code: 'COM3503',
                      academic_year_end: 2018,
                      semester: 1,
                      name: "3D Computer Graphics")

LectureModule.create!(code: 'COM2002',
                      academic_year_end: 2017,
                      semester: 1,
                      name: "Human Centered Systems Design")

LectureModule.create!(code: 'COM1001',
                      academic_year_end: 2016,
                      semester: 0,
                      name: "Introduction to Software Engineering")
