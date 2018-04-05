require "rails_helper"

feature 'Deleting todo lists' do
  scenario "Deleting a todo list", js: true do
    given_a_signed_in_user
    given_a_todo_list_exists_for_that_user
    given_user_is_on_the_todo_lists_index_page
    when_they_click_the_delete_link_for_that_list_and_confirm_the_popup
    then_they_should_be_shown_a_notice_confirming_the_list_deletion
    then_the_list_should_no_longer_exist
    then_they_should_not_be_able_to_see_the_list
  end

  scenario "Clicking cancel on deleting a todo list popup", js: true do
    given_a_signed_in_user
    given_a_todo_list_exists_for_that_user
    given_user_is_on_the_todo_lists_index_page
    when_they_click_the_delete_link_for_that_list_and_reject_the_popup
    then_the_list_should_still_exist
    then_they_should_still_be_able_to_see_the_list
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

  def when_they_click_the_delete_link_for_that_list_and_confirm_the_popup
    page.accept_confirm do
      click_link "delete_to_do_list_#{@todo_list.id}"
    end
  end

  def then_they_should_be_shown_a_notice_confirming_the_list_deletion
    expect(page).to have_content "To Do List was successfully deleted"
  end

  def then_the_list_should_no_longer_exist
    sleep(0.1)
    expect(TodoList.count).to eq 0
  end

  def then_they_should_not_be_able_to_see_the_list
    expect(page).to_not have_content 'Todo List Test'
  end

  # Scenario 2

  def when_they_click_the_delete_link_for_that_list_and_reject_the_popup
    page.dismiss_confirm do
      click_link "delete_to_do_list_#{@todo_list.id}"
    end
  end

  def then_the_list_should_still_exist
    expect(TodoList.count).to eq 1
  end

  def then_they_should_still_be_able_to_see_the_list
    expect(page).to have_content 'Todo List Test'
  end

end
