require "rails_helper"

feature 'Creating module contents' do
  scenario "Accessing the new lecture module content page of a module user owns" do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_show_page
    when_they_click_the_new_content_for_week_1_link
    then_they_should_be_redirected_to_the_new_lecture_module_page
  end

  scenario "Can't access the new lecture module content page of a module user does not own" do
    given_a_signed_in_user
    given_a_lecture_module_that_belongs_to_another_user
    given_user_is_on_the_module_show_page
    then_they_should_not_be_able_to_see_the_new_content_link
  end

  scenario "Can't access the new lecture module content page through the url" do
    given_a_signed_in_user
    when_the_user_enters_the_new_content_url_directly
    then_they_should_be_redirected_to_the_root_url
    then_they_should_see_an_alert_showing_access_denied
  end

  scenario "Creating module contents with valid pdf for week 1", js: true do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_show_page
    when_they_click_the_new_content_for_week_1_link
    when_they_fill_in_the_form_with_valid_pdf_details
    when_they_click_the_submit_button
    then_they_should_be_redirected_to_the_module_show_page
    then_they_should_be_shown_a_notice_confirming_the_content_creation
    then_the_content_should_exist
    then_they_should_be_able_to_see_the_content
  end

  scenario "Creating module contents with valid youtube link", js: true do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_show_page
    when_they_click_the_new_content_for_week_1_link
    when_they_fill_in_the_form_with_valid_youtube_link_details
    when_they_click_the_submit_button
    then_they_should_be_redirected_to_the_module_show_page
    then_they_should_be_shown_a_notice_confirming_the_content_creation
    then_the_content_should_exist
    then_they_should_be_able_to_see_the_content
  end

  scenario "Creating a lecture module with invalid details" do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_show_page
    when_they_click_the_new_content_for_week_1_link
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_the_submit_button
    then_they_should_be_shown_the_errors
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
  end

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  def when_they_click_the_new_content_for_week_1_link
    click_link "Add Content to Week 1"
  end

  def then_they_should_be_redirected_to_the_new_lecture_module_page
    expect(current_path).to eq new_lecture_module_content_path
  end

  # Scenario 2

  def given_a_signed_in_user
    @user = create(:user)
    login_as(@user)
  end

  def given_a_lecture_module_that_belongs_to_another_user
    user2 = create(:user, username: "Test 2", email: "test2@example.com")
    @lecture_module = create(:lecture_module, user: user2)
  end

  def then_they_should_not_be_able_to_see_the_new_content_link
    expect(page).to_not have_content "Add Content to Week 1"
  end

  # Scenario 3

  def when_the_user_enters_the_new_content_url_directly
    visit '/lecture_module_contents/new'
  end

  def then_they_should_be_redirected_to_the_root_url
    expect(current_path).to eq root_path
  end

  def then_they_should_see_an_alert_showing_access_denied
    expect(find('.alert')).to have_content "This URL cannot be accessed directly"
  end

  # Scenario 4

  def when_they_fill_in_the_form_with_valid_pdf_details
    fill_in 'lecture_module_content[description]', with: 'Test Content'
    select 'PDF', from: 'content-type-selector'
    expect(find('#lecture_module_content_content_file_name')).to be_visible
    attach_file('lecture_module_content[content]', Rails.root + "spec/factories/test.pdf").click
  end

  def when_they_click_the_submit_button
    click_button 'Create Lecture Module Content'
  end

  def then_they_should_be_redirected_to_the_module_show_page
    expect(current_path).to eq lecture_module_path(@lecture_module)
  end

  def then_they_should_be_shown_a_notice_confirming_the_content_creation
    expect(find('.notice')).to have_content 'Lecture Module Content was successfully created'
  end

  def then_the_content_should_exist
    expect(LectureModuleContent.count).to eq 1
  end

  def then_the_content_should_exist_in_s3
    bucket = s3.bucket('learning-platform-bucket')
  end

  def then_they_should_be_able_to_see_the_content
    expect(page).to have_content LectureModuleContent.first.title
  end

  # Scenario 5

  def when_they_fill_in_the_form_with_valid_youtube_link_details
    fill_in 'lecture_module_content[description]', with: 'Test Content'
    select 'YouTube Video', from: 'content-type-selector'
    expect(find('#lecture_module_content_youTube_link')).to be_visible
    fill_in 'lecture_module_content[youTube_link]', with: 'https://www.youtube.com/embed/yCqhdhOdS14'
  end

  # Scenario 6

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'lecture_module_content[description]', with: 'Test Content'
    select 'YouTube Video', from: 'content-type-selector'
    expect(find('#lecture_module_content_youTube_link')).to be_visible
    fill_in 'lecture_module_content[youTube_link]', with: 'https://www.thisisnotyoutube.com'
  end

  def then_they_should_be_shown_the_errors
    expect(page).to have_content 'prohibited this content from being saved'
  end
end
