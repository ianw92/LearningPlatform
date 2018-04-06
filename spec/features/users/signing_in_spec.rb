require "rails_helper"

feature 'Signing in' do
  scenario "accessing_the_application_without_being_signed_in" do
    when_someone_visits_the_application
    then_they_are_redirected_to_the_sign_in_page
  end

  scenario "Signing in with valid credentials (username)" do
    given_a_user
    given_they_are_on_the_sign_in_page
    when_they_fill_in_the_form_with_their_username_and_password
    when_they_click_log_in
    then_they_are_redirected_to_the_root_page
    then_they_are_shown_a_notice_confirming_their_log_in
  end

  scenario "Signing in with valid credentials (email)" do
    given_a_user
    given_they_are_on_the_sign_in_page
    when_they_fill_in_the_form_with_their_email_and_password
    when_they_click_log_in
    then_they_are_redirected_to_the_root_page
    then_they_are_shown_a_notice_confirming_their_log_in
  end

  scenario "Signing in with invalid credentials" do
    given_a_user
    given_they_are_on_the_sign_in_page
    when_they_fill_in_the_form_with_invalid_details
    when_they_click_log_in
    then_they_will_still_be_on_the_sign_in_page
    then_they_are_shown_an_alert_saying_invalid_details
  end

  # Scenario 1

  def when_someone_visits_the_application
    visit root_path
  end

  def then_they_are_redirected_to_the_sign_in_page
    expect(current_path).to eq new_user_session_path
  end

  # Scenario 2

  def given_a_user
    @user = create(:user)
  end

  def given_they_are_on_the_sign_in_page
    visit new_user_session_path
  end

  def when_they_fill_in_the_form_with_their_username_and_password
    fill_in 'user[login]', with: 'Test User'
    fill_in 'user[password]', with: 'password'
  end

  def when_they_click_log_in
    click_button 'Log In'
  end

  def then_they_are_redirected_to_the_root_page
    expect(current_path).to eq root_path
  end

  def then_they_are_shown_a_notice_confirming_their_log_in
    within('.notice') do
      expect(page).to have_content 'Signed in successfully'
    end
  end

  # Scenario 3

  def when_they_fill_in_the_form_with_their_email_and_password
    fill_in 'user[login]', with: 'testuser@example.com'
    fill_in 'user[password]', with: 'password'
  end

  # Scenario 4

  def when_they_fill_in_the_form_with_invalid_details
    fill_in 'user[login]', with: 'Not a user'
    fill_in 'user[password]', with: 'notmypassword'
  end

  def then_they_will_still_be_on_the_sign_in_page
    expect(current_path).to eq new_user_session_path
  end

  def then_they_are_shown_an_alert_saying_invalid_details
    within('.alert') do
      expect(page).to have_content 'Invalid Username/Email or password'
    end
  end

end
