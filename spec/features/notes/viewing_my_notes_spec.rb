require "rails_helper"

feature 'Viewing notes' do
  scenario "Viewing notes that I own for the correct week" do
    given_a_signed_in_user_with_a_lecture_module_and_content_for_weeks_1_and_2
    given_the_user_has_notes_for_weeks_1_and_2
    given_user_is_on_the_module_show_page
    then_they_should_only_be_able_to_see_the_week_1_note
    when_they_click_the_week_2_tab
    then_they_should_only_be_able_to_see_the_week_2_note
  end

  scenario "Can't view notes that belong to other users" do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_another_user_with_a_note_for_that_content
    given_user_is_on_the_module_show_page
    then_they_should_not_be_able_to_see_the_other_users_note
  end

  scenario "I can hide the notes section", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content_and_note
    given_user_is_on_the_module_show_page
    then_the_show_hide_notes_button_says_hide_notes
    when_they_click_the_show_hide_notes_button
    then_their_profile_is_updated_in_the_database
    then_they_cannot_see_the_note
    then_the_show_hide_notes_button_says_show_notes
  end

  scenario "I can show the notes section", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content_and_note
    given_the_user_cannot_see_notes
    given_user_is_on_the_module_show_page
    then_the_show_hide_notes_button_says_show_notes
    then_they_cannot_see_the_note
    when_they_click_the_show_hide_notes_button
    then_their_profile_is_updated_in_the_database
    then_they_can_see_the_note
    then_the_show_hide_notes_button_says_hide_notes
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module_and_content_for_weeks_1_and_2
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
    @lecture_module_content = create(:lecture_module_content, week: Week.second, description: 'Week 2 Content')
  end

  def given_the_user_has_notes_for_weeks_1_and_2
    note1 = create(:note, user: @user, week: Week.first)
    note2 = create(:note, user: @user, week: Week.second, body: 'Test Note 2')
  end

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  def then_they_should_only_be_able_to_see_the_week_1_note
    within('#week1') do
      expect(find_all('#body_textarea').count).to eq 1
      expect(find('#body_textarea').text).to eq 'Test Note'
    end
  end

  def when_they_click_the_week_2_tab
    within('.nav-tabs') do
      click_link('Week 2')
    end
  end

  def then_they_should_only_be_able_to_see_the_week_2_note
    within('#week2') do
      expect(find_all('#body_textarea').count).to eq 1
      expect(find('#body_textarea').text).to eq 'Test Note 2'
    end
  end

  # Scenario 2

  def given_a_signed_in_user_with_a_lecture_module_and_content
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
  end

  def given_another_user_with_a_note_for_that_content
    user2 = create(:user, username: 'Test 2', email: 'test2@example.com')
    note = create(:note, week: Week.first, user: user2)
  end

  def then_they_should_not_be_able_to_see_the_other_users_note
    within('#week1') do
      expect(find('#body_textarea').text).to eq ''
    end
  end

  # Scenario 3

  def given_a_signed_in_user_with_a_lecture_module_and_content_and_note
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
    @note = create(:note, week: Week.first, user: @user)
  end

  def then_the_show_hide_notes_button_says_hide_notes
    expect(page).to have_content "Hide Notes"
  end

  def when_they_click_the_show_hide_notes_button
    find("#show_hide_notes_btn_#{Week.first.id}").click
  end

  def then_their_profile_is_updated_in_the_database
    sleep(0.1)
    if @user.profile.show_notes?
      expect(Profile.first.show_notes).to eq false
    else
      expect(Profile.first.show_notes).to eq true
    end
  end

  def then_they_cannot_see_the_note
    within('.notes_section') do
      expect(page).to_not have_selector('textarea#body_textarea')
    end
  end

  def then_the_show_hide_notes_button_says_show_notes
    expect(page).to have_content "Show Notes"
  end

  # Scenario 4

  def given_the_user_cannot_see_notes
    @user.profile.update(show_notes: false)
  end

  def then_the_show_hide_notes_button_says_show_notes
    expect(page).to have_content "Show Notes"
  end

  def then_they_can_see_the_note
    within('.notes_section') do
      expect(find('#body_textarea').text).to eq 'Test Note'
    end
  end

end
