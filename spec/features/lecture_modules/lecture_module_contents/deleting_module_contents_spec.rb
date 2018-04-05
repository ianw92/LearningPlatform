require "rails_helper"

feature 'Deleting module contents' do
  scenario "Deleting module content of a module user owns", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_module_show_page
    when_they_click_the_delete_link_for_the_content_and_confirm_the_popup
    then_they_should_see_a_notice_confirming_content_deletion
    then_the_content_should_no_longer_exist
    then_they_should_not_be_able_to_see_the_content
  end

  scenario "Clicking cancel on deleting module content popup", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_module_show_page
    when_they_click_the_delete_link_for_the_content_and_reject_the_popup
    then_the_content_should_still_exist
    then_they_should_still_be_able_to_see_the_content
  end

  scenario "Can't delete module content of a module user doesn't own" do
    given_a_signed_in_user
    given_a_lecture_module_with_content_that_belongs_to_another_user
    given_user_is_on_the_module_show_page
    then_they_should_not_be_able_to_see_the_delete_content_link
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module_and_content
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
  end

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  def when_they_click_the_delete_link_for_the_content_and_confirm_the_popup
    page.accept_confirm do
      find("#delete_content_#{@lecture_module_content.id}").trigger('click')
    end
  end

  def then_they_should_see_a_notice_confirming_content_deletion
    expect(page).to have_content "Lecture Module Content was successfully deleted"
  end

  def then_the_content_should_no_longer_exist
    sleep(0.1)
    expect(LectureModuleContent.count).to eq 0
  end

  def then_they_should_not_be_able_to_see_the_content
    expect(page).to_not have_content 'test.pdf'
  end

  # Scenario 2

  def when_they_click_the_delete_link_for_the_content_and_reject_the_popup
    page.dismiss_confirm do
      find("#delete_content_#{@lecture_module_content.id}").trigger('click')
    end
  end

  def then_the_content_should_still_exist
    expect(LectureModuleContent.count).to eq 1
  end

  def then_they_should_still_be_able_to_see_the_content
    expect(page).to have_content 'test.pdf'
  end

  # Scenario 3

  def given_a_signed_in_user
    @user = create(:user)
    login_as(@user)
  end

  def given_a_lecture_module_with_content_that_belongs_to_another_user
    user2 = create(:user, username: "Test 2", email: "test2@example.com")
    @lecture_module = create(:lecture_module, user: user2)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
  end

  def then_they_should_not_be_able_to_see_the_delete_content_link
    expect(page).to_not have_link "delete_content_#{@lecture_module_content.id}"
  end

end
