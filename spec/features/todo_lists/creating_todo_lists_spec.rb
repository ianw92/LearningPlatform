require "rails_helper"

feature 'Creating todo lists' do
  scenario "Accessing the new to do list page" do
    given_a_signed_in_user
    given_user_is_on_the_todo_lists_index_page
    when_they_click_the_new_list_link
    then_they_should_be_redirected_to_the_new_todo_list_page
  end

  scenario "Creating a todo list with valid details" do
    given_a_signed_in_user
    given_user_is_on_the_new_todo_list_page
    when_they_fill_in_the_form_with_valid_details
    when_they_click_the_submit_button
    then_they_should_be_redirected_to_the_todo_lists_index_page
    then_they_should_be_shown_a_notice_confirming_the_list_creation
    then_the_list_should_exist
    then_they_should_be_able_to_see_the_new_list
  end

  scenario "Creating a todo list with invalid details" do
    given_a_signed_in_user
    given_user_is_on_the_new_todo_list_page
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_the_submit_button
    then_they_should_be_shown_the_errors
  end

  # Scenario 1

  def given_a_signed_in_user
    @user = create(:user)
    login_as(@user)
  end

  def given_user_is_on_the_todo_lists_index_page
    visit todo_lists_path
  end

  def when_they_click_the_new_list_link
    click_link "+ New Todo List"
  end

  def then_they_should_be_redirected_to_the_new_todo_list_page
    expect(current_path).to eq new_todo_list_path
  end

  # Scenario 2

  def given_user_is_on_the_new_todo_list_page
    visit new_todo_list_path
  end

  def when_they_fill_in_the_form_with_valid_details
    fill_in 'todo_list[title]', with: 'Test List'
  end

  def when_they_click_the_submit_button
    click_button 'Create To Do List'
  end

  def then_they_should_be_redirected_to_the_todo_lists_index_page
    expect(current_path).to eq todo_lists_path
  end

  def then_they_should_be_shown_a_notice_confirming_the_list_creation
    expect(page).to have_content 'To Do List was successfully created'
  end

  def then_the_list_should_exist
    expect(TodoList.count).to eq 1
  end

  def then_they_should_be_able_to_see_the_new_list
    expect(page).to have_content 'Test List'
  end

  # Scenario 3

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'todo_list[title]', with: ''
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this to do list from being saved'
  end
end
