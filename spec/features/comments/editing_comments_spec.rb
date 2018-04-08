require "rails_helper"

feature 'Editing comments' do
  scenario "Editing comments that the user owns", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_the_user_has_commented_on_the_content
    given_user_is_on_the_module_show_page
    when_they_click_the_comment_body_and_edit_the_content_with_a_non_empty_string
    when_they_unfocus_the_comment_body
    then_the_comment_body_is_updated_in_the_database
  end

  scenario "Can't change comment body to an empty string", js: true do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_the_user_has_commented_on_the_content
    given_user_is_on_the_module_show_page
    when_they_click_the_comment_body_and_edit_the_content_with_an_empty_string
    when_they_unfocus_the_comment_body_expect_alert
    then_the_comment_body_is_not_updated_in_the_database
  end

  scenario "Can't edit comments that the user doesn't own" do
    given_a_signed_in_user_with_a_lecture_module_and_content
    given_another_user_has_commented_on_the_content
    given_user_is_on_the_module_show_page
    then_the_comment_should_not_be_contenteditable
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

  def when_they_click_the_comment_body_and_edit_the_content_with_a_non_empty_string
    comment_body_div = find("#comment_#{@comment.id}_body")
    comment_body_div.click
    comment_body_div.set("Updated Test Comment")
  end

  def when_they_unfocus_the_comment_body
    page.find("body").click
  end

  def then_the_comment_body_is_updated_in_the_database
    sleep(0.1)
    expect(Comment.first.body).to eq 'Updated Test Comment'
  end

  # Scenario 2

  def when_they_click_the_comment_body_and_edit_the_content_with_an_empty_string
    comment_body_div = find("#comment_#{@comment.id}_body")
    comment_body_div.click
    comment_body_div.native.send_keys [:control, 'a'], :backspace
  end

  def when_they_unfocus_the_comment_body_expect_alert
    message = page.accept_confirm do
      page.find("body").click
    end
    expect(message).to eq('You cannot make your comment contain nothing. Please delete your comment if this is what you wish to do.')
  end

  def then_the_comment_body_is_not_updated_in_the_database
    sleep(0.1)
    expect(Comment.first.body).to eq 'Test Comment'
  end

  # Scenario 3

  def given_another_user_has_commented_on_the_content
    user2 = create(:user, username: 'Test 2', email: 'test2@example.com')
    @comment = create(:comment, user: user2, week: Week.first, body: 'User 2 Comment')
  end

  def then_the_comment_should_not_be_contenteditable
    page.should have_css("span#comment_#{@comment.id}_body")
    page.should_not have_css("span#comment_#{@comment.id}_body[contenteditable]")
  end

end
