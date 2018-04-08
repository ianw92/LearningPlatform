require "rails_helper"

feature 'Deleting comments' do
  scenario "Deleting comments that the user owns", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_the_user_has_commented_on_the_content
    given_user_is_on_the_module_show_page
    when_they_click_the_delete_link_for_the_comment_and_confirm_the_popup
    then_the_comment_should_no_longer_exist
    then_they_should_not_be_able_to_see_the_comment
  end

  scenario "Clicking cancel on deleting comment popup", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_the_user_has_commented_on_the_content
    given_user_is_on_the_module_show_page
    when_they_click_the_delete_link_for_the_comment_and_reject_the_popup
    then_the_comment_should_still_exist
    then_they_should_still_be_able_to_see_the_comment
  end

  scenario "Can't delete comments that the user doesn't own" do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_another_user_has_commented_on_the_content
    given_user_is_on_the_module_show_page
    then_they_should_not_be_able_to_see_the_delete_comment_link
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module_and_content
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
    @lecture_module_content = create(:lecture_module_content, week: Week.first)
  end

  def given_the_user_has_commented_on_the_content
    @comment = create(:comment, user: @user, week: Week.first, body: 'Test Comment')
  end

  def given_user_is_on_the_module_show_page
    visit lecture_module_path(@lecture_module)
  end

  def when_they_click_the_delete_link_for_the_comment_and_confirm_the_popup
    page.accept_confirm do
      find("#delete_comment_#{@comment.id}").trigger('click')
    end
  end

  def then_the_comment_should_no_longer_exist
    sleep(0.1)
    expect(Comment.count).to eq 0
  end

  def then_they_should_not_be_able_to_see_the_comment
    expect(page).to_not have_content 'Test Comment'
  end

  # Scenario 2

  def when_they_click_the_delete_link_for_the_comment_and_reject_the_popup
    page.dismiss_confirm do
      find("#delete_comment_#{@comment.id}").trigger('click')
    end
  end

  def then_the_comment_should_still_exist
    expect(Comment.count).to eq 1
  end

  def then_they_should_still_be_able_to_see_the_comment
    expect(page).to have_content 'Test Comment'
  end

  # Scenario 3

  def given_another_user_has_commented_on_the_content
    user2 = create(:user, username: 'Test 2', email: 'test2@example.com')
    @comment = create(:comment, user: user2, week: Week.first, body: 'User 2 Comment')
  end

  def then_they_should_not_be_able_to_see_the_delete_comment_link
    expect(page).to_not have_link "delete_comment_#{@comment.id}"
  end

end
