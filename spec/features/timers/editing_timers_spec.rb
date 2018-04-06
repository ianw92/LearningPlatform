require "rails_helper"

feature 'Editing timers' do

  scenario "Editing the study timer length", js: true do
    given_a_signed_in_user_on_the_root_page
    when_they_click_the_timer_dropdown_and_choose_settings
    then_the_timer_settings_modal_should_be_visible
    when_they_change_the_study_timer_length_to_a_valid_value
    when_they_click_the_save_changes_button
    then_the_timer_should_be_updated_in_the_database('study')
    then_a_notice_should_be_displayed_confirming_update
  end

  scenario "Editing the short break length", js: true do
    given_a_signed_in_user_on_the_root_page
    when_they_click_the_timer_dropdown_and_choose_settings
    then_the_timer_settings_modal_should_be_visible
    when_they_change_the_short_break_length_to_a_valid_value
    when_they_click_the_save_changes_button
    then_the_timer_should_be_updated_in_the_database('short')
    then_a_notice_should_be_displayed_confirming_update
  end

  scenario "Editing the long_break length", js: true do
    given_a_signed_in_user_on_the_root_page
    when_they_click_the_timer_dropdown_and_choose_settings
    then_the_timer_settings_modal_should_be_visible
    when_they_change_the_long_break_length_to_a_valid_value
    when_they_click_the_save_changes_button
    then_the_timer_should_be_updated_in_the_database('long')
    then_a_notice_should_be_displayed_confirming_update
  end

  # Scenario 1

  def given_a_signed_in_user_on_the_root_page
    @user = create(:user)
    login_as(@user)
    visit root_path
  end

  def when_they_click_the_timer_dropdown_and_choose_settings
    # Have to use 'visible: false'  as poltergeist doesn't see the expand navbar link
    find('#navbar-toggle-btn', visible: false).trigger('click')
    find('#timer-select-btn').click
    find('#timer-settings-btn', visible: false).trigger('click')
  end

  def then_the_timer_settings_modal_should_be_visible
    expect(page).to have_content 'Set Timer Lengths'
  end

  def when_they_change_the_study_timer_length_to_a_valid_value
    within('#timer_settings_modal') do
      fill_in 'timer[study_length]', with: 15
    end
  end

  def when_they_click_the_save_changes_button
    within('#timer_settings_modal') do
      click_button 'Save Changes'
    end
  end

  def then_the_timer_should_be_updated_in_the_database(timer_type)
    sleep(0.5)
    if timer_type == 'study'
      expect(Timer.first.study_length).to eq 15
    elsif timer_type == 'short'
      expect(Timer.first.short_break_length).to eq 15
    elsif timer_type =='long'
      expect(Timer.first.long_break_length).to eq 15
    end
  end

  def then_a_notice_should_be_displayed_confirming_update
    expect(find('.notice')).to have_content 'Timer was successfully updated'
  end

  # Scenario 2

  def when_they_change_the_short_break_length_to_a_valid_value
    within('#timer_settings_modal') do
      fill_in 'timer[short_break_length]', with: 15
    end
  end

  # Scenario 3

  def when_they_change_the_long_break_length_to_a_valid_value
    within('#timer_settings_modal') do
      fill_in 'timer[long_break_length]', with: 15
    end
  end

end
