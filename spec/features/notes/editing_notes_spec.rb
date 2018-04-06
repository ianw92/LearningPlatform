require "rails_helper"

feature 'Editing notes' do
  scenario "Editing an existing note I own", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content_and_note
    given_user_is_on_the_module_show_page
    when_they_change_the_contents_of_the_notes_text_area
    when_they_click_the_submit_notes_button
    then_the_note_should_be_updated_in_the_database
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

  def when_they_change_the_contents_of_the_notes_text_area
    within('.notes_section') do
      fill_in 'note[body]', with: 'Updated Test Note'
    end
  end

  def when_they_click_the_submit_notes_button
    within('.notes_section') do
      click_button 'Update Note'
    end
  end

  def then_the_note_should_be_updated_in_the_database
    sleep(0.5)
    expect(Note.all.count).to eq 1
    expect(Note.first.body).to eq 'Updated Test Note'
  end

end
