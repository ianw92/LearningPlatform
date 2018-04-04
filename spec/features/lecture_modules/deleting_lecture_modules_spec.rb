require "rails_helper"

feature 'Deleting lecture modules' do
  scenario "Deleting a lecture module from the module index page", js: true do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_index_page
    when_they_click_the_delete_link_for_that_module_and_confirm_the_popup
    then_they_should_be_shown_a_notice_confirming_the_module_deletion
    then_the_module_should_no_longer_exist
    then_they_should_not_be_able_to_see_the_module
  end

  scenario "Deleting a lecture module from the module show page", js: true do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_show_page
    when_they_click_the_delete_link_for_that_module_and_confirm_the_popup
    then_they_should_be_shown_a_notice_confirming_the_module_deletion
    then_they_should_be_redirected_to_the_module_index_page
    then_they_should_not_be_able_to_see_the_module
  end

  scenario "Clicking cancel on deleting a lecture module popup", js: true do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_index_page
    when_they_click_the_delete_link_for_that_module_and_reject_the_popup
    then_the_module_should_still_exist
    then_they_should_still_be_able_to_see_the_module
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

  def when_they_click_the_delete_link_for_that_module_and_confirm_the_popup
    page.accept_confirm do
      click_link "Delete Module #{@lecture_module.id}"
    end
  end

  def then_they_should_be_shown_a_notice_confirming_the_module_deletion
    expect(page).to have_content "Lecture Module was successfully deleted"
  end

  def then_the_module_should_no_longer_exist
    sleep(0.1)
    expect(LectureModule.count).to eq 0
  end

  def then_they_should_not_be_able_to_see_the_module
    expect(page).to_not have_content 'Test Module'
  end

  # Scenario 2

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  def then_they_should_be_redirected_to_the_module_index_page
    expect(current_path).to eq lecture_modules_path
  end

  # Scenario 3

  def when_they_click_the_delete_link_for_that_module_and_reject_the_popup
    page.dismiss_confirm do
      click_link "Delete Module #{@lecture_module.id}"
    end
  end

  def then_the_module_should_still_exist
    expect(LectureModule.count).to eq 1
  end

  def then_they_should_still_be_able_to_see_the_module
    expect(page).to have_content 'Test Module'
  end

end
