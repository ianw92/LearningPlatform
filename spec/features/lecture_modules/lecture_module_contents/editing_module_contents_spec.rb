require "rails_helper"

feature 'Editing module contents' do
  scenario "Accessing the edit content page" do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_module_show_page
    when_they_click_the_edit_link_for_the_content
    then_they_should_be_redirected_to_the_edit_page_for_that_content
  end

  scenario "Editing module content of a module user owns with valid details", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_edit_page_for_that_content
    when_they_fill_in_the_form_with_valid_details
    when_they_click_the_submit_button
    then_they_should_be_redirected_to_the_module_show_page
    then_they_should_be_shown_a_notice_confirming_the_content_was_updated
    then_they_should_be_able_to_see_the_updated_content
  end

  scenario "Editing module content of a module user owns with invalid details", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_edit_page_for_that_content
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_the_submit_button
    then_they_should_be_shown_the_errors
  end

  scenario "Can't edit module content of a module user doesn't own" do
    given_a_signed_in_user
    given_a_lecture_module_with_content_that_belongs_to_another_user
    given_user_is_on_the_module_show_page
    then_they_should_not_be_able_to_see_the_edit_content_link
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

  def when_they_click_the_edit_link_for_the_content
    click_link "edit_content_#{@lecture_module_content.id}"
  end

  def then_they_should_be_redirected_to_the_edit_page_for_that_content
    expect(current_path).to eq edit_lecture_module_content_path(@lecture_module_content)
  end

  # Scenario 2

  def given_user_is_on_the_edit_page_for_that_content
    visit edit_lecture_module_content_path(@lecture_module_content)
  end

  def when_they_fill_in_the_form_with_valid_details
    fill_in 'lecture_module_content[description]', with: 'Updated Test Content'
    select 'PDF', from: 'content-type-selector'
    expect(find('#lecture_module_content_content_file_name')).to be_visible
    attach_file('lecture_module_content[content]', Rails.root + "spec/factories/test.pdf").click
  end

  def when_they_click_the_submit_button
    click_button 'Update Lecture Module Content'
  end

  def then_they_should_be_redirected_to_the_module_show_page
    expect(current_path).to eq lecture_module_path(@lecture_module)
  end

  def then_they_should_be_shown_a_notice_confirming_the_content_was_updated
    expect(find('.notice')).to have_content 'Lecture Module Content was successfully updated'
  end

  def then_they_should_be_able_to_see_the_updated_content
    expect(page).to have_content 'Updated Test Content'
  end

  # Scenario 3

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'lecture_module_content[description]', with: 'Test Content'
    select 'YouTube Video', from: 'content-type-selector'
    expect(find('#lecture_module_content_youTube_link')).to be_visible
    fill_in 'lecture_module_content[youTube_link]', with: 'https://www.thisisnotyoutube.com'
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this content from being saved'
  end

  # Scenario 4

  def given_a_signed_in_user
    @user = create(:user)
    login_as(@user)
  end

  def given_a_lecture_module_with_content_that_belongs_to_another_user
    user2 = create(:user, username: "Test 2", email: "test2@example.com")
    @lecture_module = create(:lecture_module, user: user2)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
  end

  def then_they_should_not_be_able_to_see_the_edit_content_link
    expect(page).to_not have_link "edit_content_#{@lecture_module_content.id}"
  end

end
