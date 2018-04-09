require "rails_helper"

feature 'Deleting notes' do
  scenario "Deleting an existing note I own", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content_and_note
    given_user_is_on_the_module_show_page
    when_they_change_the_contents_of_the_notes_text_area_to_an_empty_string
    when_they_click_the_submit_notes_button
    then_the_note_should_be_deleted_in_the_database
    then_the_notes_title_should_change_to_say_add_new_note
    then_the_note_submit_button_should_change_to_say_create
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module_and_content_and_note
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
    @note = create(:note, week: Week.first, user: @user)
  end

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  def when_they_change_the_contents_of_the_notes_text_area_to_an_empty_string
    within('.notes_section') do
      fill_in 'note[body]', with: ''
    end
  end

  def when_they_click_the_submit_notes_button
    within('.notes_section') do
      click_button 'Update Note'
    end
  end

  def then_the_note_should_be_deleted_in_the_database
    sleep(0.5)
    expect(Note.all.count).to eq 0
  end

  def then_the_notes_title_should_change_to_say_add_new_note
    within('.notes_section') do
      expect(find('h3').text).to eq 'Add New Note'
    end
  end

  def then_the_note_submit_button_should_change_to_say_create
    within('.notes_section') do
      expect(find('input').value).to eq 'Create Note'
    end
  end

end
