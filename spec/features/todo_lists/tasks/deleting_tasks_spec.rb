require "rails_helper"

feature 'Deleting tasks' do
  scenario "Deleting a task", js: true do
    given_a_signed_in_user_with_a_todo_list_and_a_task
    given_user_is_on_the_todo_lists_index_page
    when_they_click_the_delete_link_for_the_task_and_confirm_the_popup
    then_the_task_should_no_longer_exist
    then_they_should_not_be_able_to_see_the_task
  end

  scenario "Clicking cancel on deleting a task popup", js: true do
    given_a_signed_in_user_with_a_todo_list_and_a_task
    given_user_is_on_the_todo_lists_index_page
    when_they_click_the_delete_link_for_the_task_and_reject_the_popup
    then_the_task_should_still_exist
    then_they_should_still_be_able_to_see_the_task
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

  def when_they_click_the_delete_link_for_the_task_and_confirm_the_popup
    page.accept_confirm do
      click_link "delete_task_#{@task.id}"
    end
  end

  def then_the_task_should_no_longer_exist
    sleep(0.1)
    expect(Task.count).to eq 0
  end

  def then_they_should_not_be_able_to_see_the_task
    expect(page).to_not have_content 'Test Task'
  end

  # Scenario 2

  def when_they_click_the_delete_link_for_the_task_and_reject_the_popup
    page.dismiss_confirm do
      click_link "delete_task_#{@task.id}"
    end
  end

  def then_the_task_should_still_exist
    expect(Task.count).to eq 1
  end

  def then_they_should_still_be_able_to_see_the_task
    expect(page).to have_content 'Test Task'
  end

end
