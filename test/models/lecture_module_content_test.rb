require 'test_helper'

class LectureModuleContentTest < ActiveSupport::TestCase
  setup do
    @lecture_module_content = lecture_module_contents(:com3501_2018_week1)
  end

  test "code, academic_year_end and week must not be empty" do
    lecture_module_content = lecture_module_contents(:empty_test)
    assert lecture_module_content.invalid?
    assert lecture_module_content.errors[:code].any?
    assert lecture_module_content.errors[:academic_year_end].any?
    assert lecture_module_content.errors[:week].any?
  end

  #TODO
  test "content must be a pdf file" do

  end

  test "code must be within 5 and 20 characters" do
    @lecture_module_content.code = "1234"
    assert @lecture_module_content.invalid?
    assert @lecture_module_content.errors[:code].any?

    @lecture_module_content.code = "123456789012345678901" # 21 chars
    assert @lecture_module_content.invalid?
    assert @lecture_module_content.errors[:code].any?
  end

  test "module must exist and id, code, and year_end must match" do
    @lecture_module_content.code = "COM INVALID"
    assert @lecture_module_content.invalid?
    assert_equal ["and academic year end pair must exist"], @lecture_module_content.errors.messages[:code]
  end

  test "get_content_for_module returns all and only content for a given module in week order" do
    lecture_module = lecture_modules(:com3501_2018)
    content = LectureModuleContent.get_content_for_module(lecture_module)
    assert_equal content.size, 3
    assert_equal content.first, lecture_module_contents(:com3501_2018_week1)
    assert_equal content.last, lecture_module_contents(:com3501_2018_week3)
  end

  #TODO
  test "get_content_for_module_and_week returns all and only content for a given week of a given module" do

  end


end
