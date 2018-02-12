require 'test_helper'

class LectureModuleContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lecture_module_content = lecture_module_contents(:one)
  end

  test "should get index" do
    get lecture_module_contents_url
    assert_response :success
  end

  test "should get new" do
    get new_lecture_module_content_url
    assert_response :success
  end

  test "should create lecture_module_content" do
    assert_difference('LectureModuleContent.count') do
      post lecture_module_contents_url, params: { lecture_module_content: { academic_year_end: @lecture_module_content.academic_year_end, code: @lecture_module_content.code, data_source: @lecture_module_content.data_source, description: @lecture_module_content.description, lecture_module_id: @lecture_module_content.lecture_module_id, week: @lecture_module_content.week } }
    end

    assert_redirected_to lecture_module_content_url(LectureModuleContent.last)
  end

  test "should show lecture_module_content" do
    get lecture_module_content_url(@lecture_module_content)
    assert_response :success
  end

  test "should get edit" do
    get edit_lecture_module_content_url(@lecture_module_content)
    assert_response :success
  end

  test "should update lecture_module_content" do
    patch lecture_module_content_url(@lecture_module_content), params: { lecture_module_content: { academic_year_end: @lecture_module_content.academic_year_end, code: @lecture_module_content.code, data_source: @lecture_module_content.data_source, description: @lecture_module_content.description, lecture_module_id: @lecture_module_content.lecture_module_id, week: @lecture_module_content.week } }
    assert_redirected_to lecture_module_content_url(@lecture_module_content)
  end

  test "should destroy lecture_module_content" do
    assert_difference('LectureModuleContent.count', -1) do
      delete lecture_module_content_url(@lecture_module_content)
    end

    assert_redirected_to lecture_module_contents_url
  end
end
