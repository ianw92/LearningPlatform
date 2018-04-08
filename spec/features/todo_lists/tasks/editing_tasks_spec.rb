require "rails_helper"

feature 'Editing tasks' do
  feature "in place on the todo lists page" do
    scenario "Editing a tasks title in place with a valid title", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_user_is_on_the_todo_lists_index_page
      when_they_click_the_task_title_and_edit_the_content_with_a_valid_title
      when_they_unfocus_the_tasks_title
      then_the_task_title_is_updated_in_the_database
    end

    scenario "Editing a tasks title in place with an invalid title", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_user_is_on_the_todo_lists_index_page
      when_they_click_the_task_title_and_edit_the_content_with_an_invalid_title
      when_they_unfocus_the_tasks_title
      then_the_task_title_is_not_updated_in_the_database
    end
  end

  feature "in place on the todo lists popover" do
    # scenario "Editing a tasks title in place with a valid title", js: true do
    #   given_a_signed_in_user_with_a_todo_list_and_a_task
    #   given_user_is_on_the_todo_lists_index_page
    #   when_they_click_the_task_title_and_edit_the_content_with_a_valid_title
    #   when_they_unfocus_the_tasks_title
    #   then_the_task_title_is_updated_in_the_database
    # end
    #
    # scenario "Editing a tasks title in place with an invalid title", js: true do
    #   given_a_signed_in_user_with_a_todo_list_and_a_task
    #   given_user_is_on_the_todo_lists_index_page
    #   when_they_click_the_task_title_and_edit_the_content_with_an_invalid_title
    #   when_they_unfocus_the_tasks_title
    #   then_the_task_title_is_not_updated_in_the_database
    # end
  end

  feature "on the edit tasks page" do
    scenario "Accessing the edit to do list page" do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_user_is_on_the_todo_lists_index_page
      when_they_click_the_edit_link_for_the_task
      then_they_should_be_redirected_to_the_edit_page_for_that_task
    end

    scenario "Editing a task with valid details" do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_user_is_on_the_edit_page_for_that_task
      when_they_fill_in_the_form_with_valid_details
      when_they_click_the_submit_button
      then_they_should_be_redirected_to_the_todo_lists_index_page
      then_they_should_be_shown_a_notice_confirming_the_task_was_updated
      then_they_should_be_able_to_see_the_updated_task
    end

    scenario "Editing a task with invalid details" do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_user_is_on_the_edit_page_for_that_task
      when_they_fill_in_the_form_with_invalid_details
      when_they_click_the_submit_button
      then_they_should_be_shown_the_errors
    end
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_todo_list_and_a_task
    user = create(:user)
    login_as(user)
    todo_list = create(:todo_list, user: user)
    @task = create(:task, todo_list: todo_list)
  end

  def given_user_is_on_the_todo_lists_index_page
    visit todo_lists_path
  end

  def when_they_click_the_task_title_and_edit_the_content_with_a_valid_title
    task_title_div = find("#task_#{@task.id}_title")
    task_title_div.click
    task_title_div.set("Updated Test Task")
  end

  def when_they_unfocus_the_tasks_title
    page.find("body").click
  end

  def then_the_task_title_is_updated_in_the_database
    sleep(0.1)
    expect(Task.first.title).to eq 'Updated Test Task'
  end

  # Scenario 2

  def when_they_click_the_task_title_and_edit_the_content_with_an_invalid_title
    find("#task_#{@task.id}_title").click
    page.execute_script("$('#task_#{@task.id}_title').html('');")
  end

  def then_the_task_title_is_not_updated_in_the_database
    sleep(0.1)
    expect(Task.first.title).to eq 'Test Task'
  end

  # Scenario 3

  def when_they_click_the_edit_link_for_the_task
    click_link "edit_task_#{@task.id}"
  end

  def then_they_should_be_redirected_to_the_edit_page_for_that_task
    expect(current_path).to eq edit_task_path(@task)
  end

  # Scenario 4

  def given_user_is_on_the_edit_page_for_that_task
    visit edit_task_path(@task)
  end

  def when_they_fill_in_the_form_with_valid_details
    fill_in 'task[title]', with: 'Updated Test Task'
    fill_in 'task[due_date]', with: '2018-01-02'
  end

  def when_they_click_the_submit_button
    click_button 'Update Task'
  end

  def then_they_should_be_redirected_to_the_todo_lists_index_page
    expect(current_path).to eq todo_lists_path
  end

  def then_they_should_be_shown_a_notice_confirming_the_task_was_updated
    expect(page).to have_content 'Task was successfully updated'
  end

  def then_they_should_be_able_to_see_the_updated_task
    expect(page).to have_content 'Updated Test Task'
  end

  # Scenario 5

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'task[title]', with: ''
    fill_in 'task[due_date]', with: ''
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this task from being saved'
  end

end
