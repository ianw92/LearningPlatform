require "rails_helper"

feature 'Creating comments' do
  scenario "Create a comment for a lecture module week", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_module_show_page
    when_they_fill_in_the_comments_form_with_valid_details
    when_they_click_the_submit_comment_button
    then_the_comment_should_exist_in_the_database
    then_the_comment_should_be_visible
  end

  scenario "Can't create a comment for a lecture module week that has no content" do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_show_page
    then_the_comments_section_should_not_be_visible
  end

  scenario "Can't create a comment for a lecture module that is not one of 'my modules'" do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_lecture_module_is_not_in_users_modules
    given_user_is_on_the_module_show_page
    then_the_comments_section_should_be_disabled
  end

  scenario "Can't create a comment with no content", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_module_show_page
    when_they_do_not_enter_anything_in_the_comments_text_area
    then_the_comment_submit_button_is_disabled
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

  def when_they_fill_in_the_comments_form_with_valid_details
    within('.comments_section') do
      fill_in 'comment[body]', with: 'Test Comment'
    end
  end

  def when_they_click_the_submit_comment_button
    within('.comments_section') do
      click_button 'Create Comment'
    end
  end

  def then_the_comment_should_exist_in_the_database
    sleep(0.5)
    expect(Comment.all.count).to eq 1
  end

  def then_the_comment_should_be_visible
    within('.comments_section') do
      expect(page).to have_content "#{@user.username}"
      expect(page).to have_content 'Test Comment'
    end
  end

  # Scenario 2

  def given_a_signed_in_user_with_a_lecture_module
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
  end

  def then_the_comments_section_should_not_be_visible
    expect(page).to_not have_selector('.comments_section')
  end

  # Scenario 3

  def given_lecture_module_is_not_in_users_modules
    UserModuleLinker.destroy_all
  end

  def then_the_comments_section_should_be_disabled
    within('.comments_section') do
      expect(page).to have_content 'Add this module to your modules to see the discussion'
    end
  end

  # Scenario 4

  def when_they_do_not_enter_anything_in_the_comments_text_area
    within('.comments_section') do
      fill_in 'comment[body]', with: ''
    end
  end

  def then_the_comment_submit_button_is_disabled
    within('.comments_section') do
      expect(page).to have_button('Create Comment', disabled: true)
    end
  end

end
