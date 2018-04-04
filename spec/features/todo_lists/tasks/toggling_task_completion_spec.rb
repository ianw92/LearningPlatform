require "rails_helper"

feature 'Toggling task completion' do
  feature "On the todo lists index page" do
    scenario "when the task is not completed", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_user_is_on_the_todo_lists_index_page
      when_they_click_the_checkbox_for_the_task
      then_the_task_completed_status_is_updated_in_the_database
      then_the_task_checkbox_should_be_ticked
    end

    scenario "when the task is completed", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_the_task_is_already_completed
      given_the_user_can_see_completed_tasks
      given_user_is_on_the_todo_lists_index_page
      when_they_click_the_checkbox_for_the_task
      then_the_task_completed_status_is_updated_in_the_database
      then_the_task_checkbox_should_not_be_ticked
    end
  end

  feature "In the todo lists popover" do
    scenario "when the task is not completed", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_user_is_on_the_module_index_page
      when_they_open_the_todo_list_popover
      when_they_click_the_checkbox_for_the_task
      then_the_task_completed_status_is_updated_in_the_database
      then_the_task_checkbox_should_be_ticked
    end

    scenario "when the task is completed", js: true do
      given_a_signed_in_user_with_a_todo_list_and_a_task
      given_the_task_is_already_completed
      given_the_user_can_see_completed_tasks
      given_user_is_on_the_module_index_page
      when_they_open_the_todo_list_popover
      when_they_click_the_checkbox_for_the_task
      then_the_task_completed_status_is_updated_in_the_database
      then_the_task_checkbox_should_not_be_ticked
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

  def when_they_click_the_checkbox_for_the_task
    find("#task_#{@task.id}_checkbox", visible: false).trigger('click')
  end

  def then_the_task_completed_status_is_updated_in_the_database
    sleep(0.2)
    if @task.completed?
      expect(Task.first.completed).to eq false
    else
      expect(Task.first.completed).to eq true
    end
  end

  def then_the_task_checkbox_should_be_ticked
    elem = find("#task_#{@task.id}_checkbox", visible: false)
    expect(elem.checked?).to eq true
  end

  # Scenario 2

  def given_the_task_is_already_completed
    @task.update(completed: true)
  end

  def given_the_user_can_see_completed_tasks
    Profile.first.show_completed_tasks = true
  end

  def then_the_task_checkbox_should_not_be_ticked
    elem = find("#task_#{@task.id}_checkbox", visible: false)
    expect(elem.checked?).to eq false
  end

  # Scenario 3

  def given_user_is_on_the_module_index_page
    visit root_path
  end

  def when_they_open_the_todo_list_popover
    find('[data-toggle="popover"]').click
  end

end
