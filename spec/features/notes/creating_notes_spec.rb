require "rails_helper"

feature 'Creating notes' do
  scenario "Create a note for a lecture module week", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_module_show_page
    when_they_fill_in_the_notes_form_with_valid_details
    when_they_click_the_submit_notes_button
    then_the_note_should_exist_in_the_database
    then_the_note_submit_button_should_change_to_say_update
  end

  scenario "Can't create a note for a lecture module week that has no content" do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_show_page
    then_the_notes_section_should_not_be_visible
  end

  scenario "Can't create a note with no content", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_user_is_on_the_module_show_page
    when_they_click_the_submit_notes_button_without_entering_a_note_body
    then_the_note_will_not_be_created_in_the_database
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

  def when_they_fill_in_the_notes_form_with_valid_details
    within('.notes_section') do
      fill_in 'note[body]', with: 'Test Note'
    end
  end

  def when_they_click_the_submit_notes_button
    within('.notes_section') do
      click_button 'Create Note'
    end
  end

  def then_the_note_should_exist_in_the_database
    sleep(0.5)
    expect(Note.all.count).to eq 1
  end

  def then_the_note_submit_button_should_change_to_say_update
    within('.notes_section') do
      expect(find('input').value).to eq 'Update Note'
    end
  end

  # Scenario 2

  def given_a_signed_in_user_with_a_lecture_module
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
  end

  def then_the_notes_section_should_not_be_visible
    expect(page).to_not have_selector('.notes_section')
  end

  # Scenario 3

  def when_they_click_the_submit_notes_button_without_entering_a_note_body
    within('.notes_section') do
      fill_in 'note[body]', with: ''
      click_button 'Create Note'
    end
  end

  def then_the_note_will_not_be_created_in_the_database
    expect(Note.all.count).to eq 0
  end

end
