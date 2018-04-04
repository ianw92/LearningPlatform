require "rails_helper"

feature 'Creating lecture modules' do
  scenario "Accessing the new lecture_module page" do
    given_a_signed_in_user
    given_user_is_on_the_module_index_page
    when_they_click_the_new_lecture_module_link
    then_they_should_be_redirected_to_the_new_lecture_module_page
  end

  scenario "Creating a lecture module with valid details" do
    given_a_signed_in_user
    given_user_is_on_the_new_lecture_module_page
    when_they_fill_in_the_form_with_valid_details
    when_they_click_the_submit_button
    then_they_should_be_redirected_to_the_module_show_page
    then_they_should_be_shown_a_notice_confirming_the_module_creation
    then_the_module_should_exist
    then_they_should_be_able_to_see_the_full_title_of_the_new_module
  end

  scenario "Creating a lecture module with invalid details" do
    given_a_signed_in_user
    given_user_is_on_the_new_lecture_module_page
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_the_submit_button
    then_they_should_be_shown_the_errors
  end

  # Scenario 1

  def given_a_signed_in_user
    @user = create(:user)
    login_as(@user)
  end

  def given_user_is_on_the_module_index_page
    visit lecture_modules_path
  end

  def when_they_click_the_new_lecture_module_link
    click_link "New Lecture Module"
  end

  def then_they_should_be_redirected_to_the_new_lecture_module_page
    expect(current_path).to eq new_lecture_module_path
  end

  # Scenario 2

  def given_user_is_on_the_new_lecture_module_page
    visit new_lecture_module_path
  end

  def when_they_fill_in_the_form_with_valid_details
    fill_in 'lecture_module[code]', with: 'Test 111'
    fill_in 'lecture_module[academic_year_end]', with: Date.today.year
    select 'Academic Year', from: 'Semester'
    fill_in 'lecture_module[name]', with: 'Test Module'
  end

  def when_they_click_the_submit_button
    click_button 'Create Lecture Module'
  end

  def then_they_should_be_redirected_to_the_module_show_page
    expect(current_path).to eq lecture_module_path(LectureModule.first)
  end

  def then_they_should_be_shown_a_notice_confirming_the_module_creation
    expect(page).to have_content 'Lecture Module was successfully created'
  end

  def then_the_module_should_exist
    expect(LectureModule.count).to eq 1
  end

  def then_they_should_be_able_to_see_the_full_title_of_the_new_module
    expect(page).to have_content LectureModule.first.get_module_full_title
  end

  # Scenario 3

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'lecture_module[code]', with: ''
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this lecture module from being saved'
  end
end
