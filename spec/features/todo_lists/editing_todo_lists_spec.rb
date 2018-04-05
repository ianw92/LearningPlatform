require "rails_helper"

feature 'Editing todo lists' do
  scenario "Accessing the edit to do list page" do
    given_a_signed_in_user
    given_a_todo_list_exists_for_that_user
    given_user_is_on_the_todo_lists_index_page
    when_they_click_the_edit_link_for_that_list
    then_they_should_be_redirected_to_the_edit_page_for_that_list
  end

  scenario "Editing a todo list with valid details" do
    given_a_signed_in_user
    given_a_todo_list_exists_for_that_user
    given_user_is_on_the_edit_page_for_that_list
    when_they_fill_in_the_form_with_valid_details
    when_they_click_the_submit_button
    then_they_should_be_redirected_to_the_todo_lists_index_page
    then_they_should_be_shown_a_notice_confirming_the_list_was_updated
    then_they_should_be_able_to_see_the_updated_list
  end

  scenario "Editing a todo list with invalid details" do
    given_a_signed_in_user
    given_a_todo_list_exists_for_that_user
    given_user_is_on_the_edit_page_for_that_list
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_the_submit_button
    then_they_should_be_shown_the_errors
  end

  # Scenario 1

  def given_a_signed_in_user
    @user = create(:user)
    login_as(@user)
  end

  def given_a_todo_list_exists_for_that_user
    @todo_list = create(:todo_list, user: @user)
  end

  def given_user_is_on_the_todo_lists_index_page
    visit todo_lists_path
  end

  def when_they_click_the_edit_link_for_that_list
    click_link "edit_to_do_list_#{@todo_list.id}"
  end

  def then_they_should_be_redirected_to_the_edit_page_for_that_list
    expect(current_path).to eq edit_todo_list_path(@todo_list)
  end

  # Scenario 2

  def given_user_is_on_the_edit_page_for_that_list
    visit edit_todo_list_path(@todo_list)
  end

  def when_they_fill_in_the_form_with_valid_details
    fill_in 'todo_list[title]', with: 'Updated Test List'
  end

  def when_they_click_the_submit_button
    click_button 'Update To Do List'
  end

  def then_they_should_be_redirected_to_the_todo_lists_index_page
    expect(current_path).to eq todo_lists_path
  end

  def then_they_should_be_shown_a_notice_confirming_the_list_was_updated
    expect(page).to have_content 'To Do List was successfully updated'
  end

  def then_they_should_be_able_to_see_the_updated_list
    expect(page).to have_content 'Updated Test List'
  end

  # Scenario 3

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'todo_list[title]', with: ''
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this to do list from being saved'
  end

end
