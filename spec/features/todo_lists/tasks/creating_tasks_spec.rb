require "rails_helper"

feature 'Creating tasks' do
  scenario "Creating a task with valid details", js: true do
    given_a_signed_in_user_with_a_todo_list
    given_user_is_on_the_todo_lists_index_page
    when_they_fill_in_the_form_with_valid_details
    when_they_click_the_submit_button
    then_the_task_should_exist
    then_the_task_should_be_visible_on_the_page
  end

  scenario "Creating a task list with invalid details" do
    given_a_signed_in_user_with_a_todo_list
    given_user_is_on_the_todo_lists_index_page
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_the_submit_button
    then_the_task_should_not_exist
    then_they_should_be_shown_the_errors
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_todo_list
    user = create(:user)
    login_as(user)
    @todo_list = create(:todo_list, user: user)
  end

  def given_user_is_on_the_todo_lists_index_page
    visit todo_lists_path
  end

  def when_they_fill_in_the_form_with_valid_details
    fill_in 'task[title]', with: 'Test Task'
    fill_in 'task[due_date]', with: '2018-01-01'
  end

  def when_they_click_the_submit_button
    click_button 'Create Task'
  end

  def then_the_task_should_exist
    sleep 0.1
    expect(Task.count).to eq 1
  end

  def then_the_task_should_be_visible_on_the_page
    task = Task.first
    find('.new_task').find("#task_#{task.id}_title")
  end

  # Scenario 2

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'task[title]', with: ''
    fill_in 'task[due_date]', with: ''
  end

  def then_the_task_should_not_exist
    sleep 0.1
    expect(Task.count).to eq 0
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this task from being saved'
  end
  
end
