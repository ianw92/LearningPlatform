require 'test_helper'

class LectureModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lecture_module = lecture_modules(:one)
  end

  test "should get index" do
    get lecture_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_lecture_module_url
    assert_response :success
  end

  test "should create lecture_module" do
    assert_difference('LectureModule.count') do
      post lecture_modules_url, params: { lecture_module: { academic_year_end: @lecture_module.academic_year_end, code: @lecture_module.code, name: @lecture_module.name, semester: @lecture_module.semester } }
    end

    assert_redirected_to lecture_module_url(LectureModule.last)
  end

  test "should show lecture_module" do
    get lecture_module_url(@lecture_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_lecture_module_url(@lecture_module)
    assert_response :success
  end

  test "should update lecture_module" do
    patch lecture_module_url(@lecture_module), params: { lecture_module: { academic_year_end: @lecture_module.academic_year_end, code: @lecture_module.code, name: @lecture_module.name, semester: @lecture_module.semester } }
    assert_redirected_to lecture_module_url(@lecture_module)
  end

  test "should destroy lecture_module" do
    assert_difference('LectureModule.count', -1) do
      delete lecture_module_url(@lecture_module)
    end

    assert_redirected_to lecture_modules_url
  end
end
