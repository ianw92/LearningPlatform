require 'test_helper'

class LectureModuleTest < ActiveSupport::TestCase
  setup do
    @lecture_module = lecture_modules(:com3501_2018)
  end

  test "lecture module attributes must not be empty" do
    lecture_module = LectureModule.new
    assert lecture_module.invalid?
    assert lecture_module.errors[:code].any?
    assert lecture_module.errors[:academic_year_end].any?
    assert lecture_module.errors[:semester].any?
    assert lecture_module.errors[:name].any?
  end

  test "lecture module code must be within 5 and 20 characters" do
    @lecture_module.code = "1234"
    assert @lecture_module.invalid?
    assert @lecture_module.errors[:code].any?

    @lecture_module.code = "123456789012345678901" # 21 chars
    assert @lecture_module.invalid?
    assert @lecture_module.errors[:code].any?
  end

  test "lecture module academic year end must be positive" do
    @lecture_module.academic_year_end = -1
    assert @lecture_module.invalid?
    assert @lecture_module.errors[:academic_year_end].any?
  end

  test "lecture module semester must be 0, 1 or 2" do
    @lecture_module.semester = -1
    assert @lecture_module.invalid?
    assert @lecture_module.errors[:semester].any?

    @lecture_module.semester = 3
    assert @lecture_module.invalid?
    assert @lecture_module.errors[:semester].any?

    @lecture_module.semester = 0
    assert @lecture_module.valid?
  end

  test "lecture module name must be within 5 and 50 characters" do
    @lecture_module.name = "1234"
    assert @lecture_module.invalid?
    assert @lecture_module.errors[:name].any?

    @lecture_module.name = "123456789012345678901234567890123456789012345678901" # 51 chars
    assert @lecture_module.invalid?
    assert @lecture_module.errors[:name].any?
  end
end
