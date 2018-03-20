require 'test_helper'

class TimersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timer = timers(:one)
  end

  test "should get index" do
    get timers_url
    assert_response :success
  end

  test "should get new" do
    get new_timer_url
    assert_response :success
  end

  test "should create timer" do
    assert_difference('Timer.count') do
      post timers_url, params: { timer: { long_break_length: @timer.long_break_length, short_break_length: @timer.short_break_length, study_length: @timer.study_length, user_id: @timer.user_id } }
    end

    assert_redirected_to timer_url(Timer.last)
  end

  test "should show timer" do
    get timer_url(@timer)
    assert_response :success
  end

  test "should get edit" do
    get edit_timer_url(@timer)
    assert_response :success
  end

  test "should update timer" do
    patch timer_url(@timer), params: { timer: { long_break_length: @timer.long_break_length, short_break_length: @timer.short_break_length, study_length: @timer.study_length, user_id: @timer.user_id } }
    assert_redirected_to timer_url(@timer)
  end

  test "should destroy timer" do
    assert_difference('Timer.count', -1) do
      delete timer_url(@timer)
    end

    assert_redirected_to timers_url
  end
end
