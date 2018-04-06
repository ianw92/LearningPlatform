require "rails_helper"

feature 'Viewing comments' do
  scenario "Viewing comments for the correct week by multiple_users" do
    given_a_signed_in_user_with_a_lecture_module_and_content_for_weeks_1_and_2
    given_the_user_has_commented_on_weeks_1_and_2
    given_another_user_has_commented_on_weeks_1_and_2
    given_user_is_on_the_module_show_page
    then_they_should_be_able_to_see_all_the_week_1_comments
    then_they_should_not_be_able_to_see_comments_for_week_2
    when_they_click_the_week_2_tab
    then_they_should_be_able_to_see_all_the_week_2_comments
    then_they_should_not_be_able_to_see_comments_for_week_1
  end

  scenario "Can't view comments for a module not part of 'my_modules'" do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_lecture_module_is_not_in_users_modules
    given_another_user_has_commented_on_week_1
    given_user_is_on_the_module_show_page
    then_they_should_not_be_able_to_see_the_comments
    then_they_should_be_able_to_see_a_message_saying_why_they_cannot_see_the_comments
  end

  scenario "I can hide the comments section", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content_and_comment
    given_user_is_on_the_module_show_page
    then_the_show_hide_comments_button_says_hide_discussion
    when_they_click_the_show_hide_comments_button
    then_their_profile_is_updated_in_the_database
    then_they_cannot_see_the_comments
    then_the_show_hide_comments_button_says_show_discussion
  end

  scenario "I can show the comments section", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content_and_comment
    given_the_user_cannot_see_comments
    given_user_is_on_the_module_show_page
    then_the_show_hide_comments_button_says_show_discussion
    then_they_cannot_see_the_comments
    when_they_click_the_show_hide_comments_button
    then_their_profile_is_updated_in_the_database
    then_they_can_see_the_comments
    then_the_show_hide_comments_button_says_hide_discussion
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module_and_content_for_weeks_1_and_2
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
    @lecture_module_content = create(:lecture_module_content, week: Week.second, description: 'Week 2 Content')
  end

  def given_the_user_has_commented_on_weeks_1_and_2
    comment1 = create(:comment, user: @user, week: Week.first, body: 'Test Comment 1')
    comment2 = create(:comment, user: @user, week: Week.second, body: 'Test Comment 2')
  end

  def given_another_user_has_commented_on_weeks_1_and_2
    user2 = create(:user, username: 'Test 2', email: 'test2@example.com')
    comment3 = create(:comment, user: user2, week: Week.first, body: 'User 2 Comment 1')
    comment4 = create(:comment, user: user2, week: Week.second, body: 'User 2 Comment 2')
  end

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  def then_they_should_be_able_to_see_all_the_week_1_comments
    within("#week1") do
      expect(page).to have_content 'Test Comment 1'
      expect(page).to have_content 'User 2 Comment 1'
    end
  end

  def then_they_should_not_be_able_to_see_comments_for_week_2
    within("#week1") do
      expect(page).to_not have_content 'Test Comment 2'
      expect(page).to_not have_content 'User 2 Comment 2'
    end
  end

  def when_they_click_the_week_2_tab
    within('.nav-tabs') do
      click_link('Week 2')
    end
  end

  def then_they_should_be_able_to_see_all_the_week_2_comments
    within("#week2") do
      expect(page).to have_content 'Test Comment 2'
      expect(page).to have_content 'User 2 Comment 2'
    end
  end

  def then_they_should_not_be_able_to_see_comments_for_week_1
    within("#week2") do
      expect(page).to_not have_content 'Test Comment 1'
      expect(page).to_not have_content 'User 2 Comment 1'
    end
  end

  # Scenario 2

  def given_a_signed_in_user_with_a_lecture_module_and_content
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
  end

  def given_lecture_module_is_not_in_users_modules
    UserModuleLinker.destroy_all
  end

  def given_another_user_has_commented_on_week_1
    user2 = create(:user, username: 'Test 2', email: 'test2@example.com')
    comment = create(:comment, user: user2, week: Week.first, body: 'User 2 Comment 1')
  end

  def then_they_should_not_be_able_to_see_the_comments
    within('.comments_section') do
      expect(page).to_not have_content 'User 2 Comment 1'
    end
  end

  def then_they_should_be_able_to_see_a_message_saying_why_they_cannot_see_the_comments
    within('.comments_section') do
      expect(page).to have_content 'Add this module to your modules to see the discussion'
    end
  end

  # Scenario 3

  def given_a_signed_in_user_with_a_lecture_module_and_content_and_comment
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
    @comment = create(:comment, week: Week.first, user: @user, body: 'Test Comment 1')
  end

  def then_the_show_hide_comments_button_says_hide_discussion
    expect(page).to have_content "Hide Discussion"
  end

  def when_they_click_the_show_hide_comments_button
    find("#show_hide_comments_btn_#{Week.first.id}").click
  end

  def then_their_profile_is_updated_in_the_database
    sleep(0.1)
    if @user.profile.show_comments?
      expect(Profile.first.show_comments).to eq false
    else
      expect(Profile.first.show_comments).to eq true
    end
  end

  def then_they_cannot_see_the_comments
    within('.comments_section') do
      expect(page).to_not have_content 'Test Comment 1'
    end
  end

  def then_the_show_hide_comments_button_says_show_discussion
    expect(page).to have_content "Show Discussion"
  end

  # Scenario 4

  def given_the_user_cannot_see_comments
    @user.profile.update(show_comments: false)
  end

  def then_they_can_see_the_comments
    within('.comments_section') do
      expect(page).to have_content 'Test Comment 1'
    end
  end

end
