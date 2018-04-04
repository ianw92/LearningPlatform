require "rails_helper"

feature 'Sorting tasks' do
  feature "On the todo lists index page" do
    feature "when the users profile is set to sort by due date" do
      scenario "and they choose to sort by title", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_user_is_on_the_todo_lists_index_page
        when_they_click_the_option_to_sort_by_title
        then_their_profile_is_updated_in_the_database("title")
        then_the_tasks_appear_in_sorted_order_by_title
      end

      scenario "and they choose to sort by position", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_user_is_on_the_todo_lists_index_page
        when_they_click_the_option_to_sort_by_position
        then_their_profile_is_updated_in_the_database("position")
        then_the_tasks_appear_in_sorted_order_by_position
      end
    end

    feature "when the users profile is set to sort by position" do
      scenario "and they choose to sort by due_date", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_the_users_tasks_are_sorted_by_position
        given_user_is_on_the_todo_lists_index_page
        when_they_click_the_option_to_sort_by_due_date
        then_their_profile_is_updated_in_the_database("due_date")
        then_the_tasks_appear_in_sorted_order_by_due_date
      end

      scenario "and they drag a task into a different position", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_the_users_tasks_are_sorted_by_position
        given_user_is_on_the_todo_lists_index_page
        when_they_drag_and_drop_a_task_to_another_position
        then_the_new_order_is_saved_in_the_database
      end
    end
  end

  feature "In the todo lists popover" do
    feature "when the users profile is set to sort by due date" do
      scenario "and they choose to sort by title", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_user_is_on_the_module_index_page
        when_they_open_the_todo_list_popover
        when_they_click_the_option_to_sort_by_title
        then_their_profile_is_updated_in_the_database("title")
        then_the_tasks_appear_in_sorted_order_by_title
      end

      scenario "and they choose to sort by position", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_user_is_on_the_module_index_page
        when_they_open_the_todo_list_popover
        when_they_click_the_option_to_sort_by_position
        then_their_profile_is_updated_in_the_database("position")
        then_the_tasks_appear_in_sorted_order_by_position
      end
    end

    feature "when the users profile is set to sort by position" do
      scenario "and they choose to sort by due_date", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_the_users_tasks_are_sorted_by_position
        given_user_is_on_the_module_index_page
        when_they_open_the_todo_list_popover
        when_they_click_the_option_to_sort_by_due_date
        then_their_profile_is_updated_in_the_database("due_date")
        then_the_tasks_appear_in_sorted_order_by_due_date
      end

      scenario "and they drag a task into a different position", js: true do
        given_a_signed_in_user_with_a_todo_list_and_two_tasks
        given_the_users_tasks_are_sorted_by_position
        given_user_is_on_the_module_index_page
        when_they_open_the_todo_list_popover
        when_they_drag_and_drop_a_task_to_another_position
        then_the_new_order_is_saved_in_the_database
      end
    end
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_todo_list_and_two_tasks
    user = create(:user)
    login_as(user)
    todo_list = create(:todo_list, user: user)
    @task = create(:task, todo_list: todo_list, position: 2)
    @task2 = create(:task, todo_list: todo_list, title: "Aa Test Task", position: 1, due_date: Date.today + 1.day)
  end

  def given_user_is_on_the_todo_lists_index_page
    visit todo_lists_path
  end

  def when_they_click_the_option_to_sort_by_title
    find("#tasks_sort_btn").click
    find(".sort_by_title_btn").click
  end

  def then_their_profile_is_updated_in_the_database(sort_param)
    sleep(0.2)
    expect(Profile.first.sort_tasks_by).to eq sort_param
  end

  def then_the_tasks_appear_in_sorted_order_by_title
    tasks = find_all('.task-item')
    expect(tasks[0]).to have_content "Aa Test Task"
    expect(tasks[1]).to have_content "Test Task"
  end

  # Scenario 2

  def when_they_click_the_option_to_sort_by_position
    find("#tasks_sort_btn").click
    find(".sort_by_position_btn").click
  end

  def then_the_tasks_appear_in_sorted_order_by_position
    tasks = find_all('.task-item')
    expect(tasks[0]).to have_content "Aa Test Task"
    expect(tasks[1]).to have_content "Test Task"
  end

  # Scenario 3

  def given_the_users_tasks_are_sorted_by_position
    Profile.first.update(sort_tasks_by: "position")
  end

  def when_they_click_the_option_to_sort_by_due_date
    find("#tasks_sort_btn").click
    find(".sort_by_due_date_btn").click
  end

  def then_the_tasks_appear_in_sorted_order_by_due_date
    tasks = find_all('.task-item')
    expect(tasks[0]).to have_content "Test Task"
    expect(tasks[1]).to have_content "Aa Test Task"
  end

  # Scenario 4

  def when_they_drag_and_drop_a_task_to_another_position
    page.find("#footer_title").trigger('click')
    task2 = find("#task_#{@task2.id}")
    target = find("#show_hide_completed_tasks_btn_#{@task.todo_list_id}")
    task2.drag_to(target)
  end

  def then_the_new_order_is_saved_in_the_database
    sleep(0.1)
    expect(Task.first.position).to eq 1
    expect(Task.last.position).to eq 2
  end

  # Scenario 5

  def given_user_is_on_the_module_index_page
    visit root_path
  end

  def when_they_open_the_todo_list_popover
    find('[data-toggle="popover"]').click
  end

end
