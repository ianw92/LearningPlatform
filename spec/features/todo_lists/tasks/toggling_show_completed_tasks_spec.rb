require "rails_helper"

feature 'Toggling show completed tasks' do
  feature "On the todo lists index page" do
    scenario "when the users profile is set to hide completed tasks", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_completed_task
      given_user_is_on_the_todo_lists_index_page
      then_they_cannot_see_the_task
      then_the_show_completed_tasks_button_says_show_completed
      when_they_click_the_show_completed_tasks_button
      then_their_profile_is_updated_in_the_database
      then_they_can_see_the_task
      then_the_show_completed_tasks_button_says_hide_completed
    end

    scenario "when the users profile is set to show completed tasks", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_completed_task
      given_the_user_can_see_completed_tasks
      given_user_is_on_the_todo_lists_index_page
      then_they_can_see_the_task
      then_the_show_completed_tasks_button_says_hide_completed
      when_they_click_the_show_completed_tasks_button
      then_their_profile_is_updated_in_the_database
      then_they_cannot_see_the_task
      then_the_show_completed_tasks_button_says_show_completed
    end
  end

  feature "In the todo lists popover" do
    scenario "when the users profile is set to hide completed tasks", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_completed_task
      given_user_is_on_the_module_index_page
      when_they_open_the_todo_list_popover
      then_they_cannot_see_the_task
      then_the_show_completed_tasks_button_says_show_completed
      when_they_click_the_show_completed_tasks_button
      then_their_profile_is_updated_in_the_database
      then_they_can_see_the_task
      then_the_show_completed_tasks_button_says_hide_completed
    end

    scenario "when the users profile is set to show completed tasks", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_completed_task
      given_the_user_can_see_completed_tasks
      given_user_is_on_the_module_index_page
      when_they_open_the_todo_list_popover
      then_they_can_see_the_task
      then_the_show_completed_tasks_button_says_hide_completed
      when_they_click_the_show_completed_tasks_button
      then_their_profile_is_updated_in_the_database
      then_they_cannot_see_the_task
      then_the_show_completed_tasks_button_says_show_completed
    end
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_todo_list_and_a_completed_task
    @user = create(:user)
    login_as(@user)
    todo_list = create(:todo_list, user: @user)
    @task = create(:task, todo_list: todo_list, completed: true)
  end

  def given_user_is_on_the_todo_lists_index_page
    visit todo_lists_path
  end

  def then_they_cannot_see_the_task
    expect(page).to_not have_content "Test Task"
  end

  def then_the_show_completed_tasks_button_says_show_completed
    expect(page).to have_content "Show Completed"
  end

  def when_they_click_the_show_completed_tasks_button
    find("#show_hide_completed_tasks_btn_#{@task.id}").click
  end

  def then_their_profile_is_updated_in_the_database
    sleep(0.2)
    if @user.profile.show_completed_tasks?
      expect(Profile.first.show_completed_tasks).to eq false
    else
      expect(Profile.first.show_completed_tasks).to eq true
    end
  end

  def then_they_can_see_the_task
    expect(page).to have_content "Test Task"
  end

  def then_the_show_completed_tasks_button_says_hide_completed
    expect(page).to have_content "Hide Completed"
  end

  # Scenario 2

  def given_the_user_can_see_completed_tasks
    @user.profile.update(show_completed_tasks: true)
  end

  # Scenario 3

  def given_user_is_on_the_module_index_page
    visit root_path
  end

  def when_they_open_the_todo_list_popover
    find('[data-toggle="popover"]').click
  end

end
