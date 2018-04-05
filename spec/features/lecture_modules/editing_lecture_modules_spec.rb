require "rails_helper"

feature 'Editing lecture modules' do
  feature "Accessing the edit module page" do
    scenario "from the module index page" do
      given_a_signed_in_user_with_a_lecture_module
      given_user_is_on_the_module_index_page
      when_they_click_the_edit_link_for_that_module
      then_they_should_be_redirected_to_the_edit_page_for_that_module
    end

    scenario "from the module show page" do
      given_a_signed_in_user_with_a_lecture_module
      given_user_is_on_the_module_show_page
      when_they_click_the_edit_link_for_that_module
      then_they_should_be_redirected_to_the_edit_page_for_that_module
    end
  end

  scenario "Editing a module with valid details" do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_edit_page_for_that_module
    when_they_fill_in_the_form_with_valid_details
    when_they_click_the_submit_button
    then_they_should_be_redirected_to_the_module_show_page
    then_they_should_be_shown_a_notice_confirming_the_module_was_updated
    then_they_should_be_able_to_see_the_updated_module
  end

  scenario "Editing a module with invalid details" do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_edit_page_for_that_module
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_the_submit_button
    then_they_should_be_shown_the_errors
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
  end

  def given_user_is_on_the_module_index_page
    visit lecture_modules_path
  end

  def when_they_click_the_edit_link_for_that_module
    click_link "edit_module_#{@lecture_module.id}"
  end

  def then_they_should_be_redirected_to_the_edit_page_for_that_module
    expect(current_path).to eq edit_lecture_module_path(@lecture_module)
  end

  # Scenario 2

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  # Scenario 3

  def given_user_is_on_the_edit_page_for_that_module
    visit edit_lecture_module_path(@lecture_module)
  end

  def when_they_fill_in_the_form_with_valid_details
    fill_in 'lecture_module[code]', with: 'Updated Test 111'
    fill_in 'lecture_module[academic_year_end]', with: Date.today.year
    select 'Academic Year', from: 'Semester'
    fill_in 'lecture_module[name]', with: 'Updated Test Module'
  end

  def when_they_click_the_submit_button
    click_button 'Update Lecture Module'
  end

  def then_they_should_be_redirected_to_the_module_show_page
    expect(current_path).to eq lecture_module_path(@lecture_module)
  end

  def then_they_should_be_shown_a_notice_confirming_the_module_was_updated
    expect(page).to have_content 'Lecture Module was successfully updated'
  end

  def then_they_should_be_able_to_see_the_updated_module
    expect(page).to have_content 'Updated Test Module'
  end

  # Scenario 4

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'lecture_module[code]', with: ''
    fill_in 'lecture_module[academic_year_end]', with: Date.today.year
    select 'Academic Year', from: 'Semester'
    fill_in 'lecture_module[name]', with: ''
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this lecture module from being saved'
  end

end
