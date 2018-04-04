require "rails_helper"

feature 'Adding/Removing lecture modules to/from my modules' do
  scenario "Removing a module to my modules", js: true do
    given_a_signed_in_user_with_a_lecture_module
    given_user_is_on_the_module_index_page
    when_they_click_the_remove_from_my_modules_button_for_that_module
    then_the_user_module_linker_should_no_longer_exist
    then_they_should_not_be_able_to_see_the_module_under_the_my_modules_section
    then_they_should_be_able_to_see_the_module_under_the_other_modules_section
  end

  scenario "Removing a module to my modules", js: true do
    given_a_signed_in_user
    given_a_lecture_module_that_belongs_to_another_user
    given_user_is_on_the_module_index_page
    when_they_click_the_add_to_my_modules_button_for_that_module
    then_a_user_module_linker_should_exist_for_them
    then_they_should_be_able_to_see_the_module_under_the_my_modules_section
    then_they_should_not_be_able_to_see_the_module_under_the_other_modules_section
  end

  # Scenario 1

  def given_a_signed_in_user_with_a_lecture_module
    @user = create(:user)
    login_as(@user)
    @lecture_module = create(:lecture_module, user: @user)
  end

  def given_user_is_on_the_module_index_page
    visit lecture_modules_path
  end

  def when_they_click_the_remove_from_my_modules_button_for_that_module
    click_button "Remove From My Modules"
  end

  def then_the_user_module_linker_should_no_longer_exist
    sleep(0.1)
    expect(UserModuleLinker.count).to eq 0
  end

  def then_they_should_not_be_able_to_see_the_module_under_the_my_modules_section
    my_modules = find('#my_modules')
    expect(my_modules).to_not have_content "Test Module"
  end

  def then_they_should_be_able_to_see_the_module_under_the_other_modules_section
    other_modules = find('#other_modules')
    expect(other_modules).to have_content "Test Module"
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

  def when_they_click_the_add_to_my_modules_button_for_that_module
    click_button "Add To My Modules"
  end

  def then_a_user_module_linker_should_exist_for_them
    sleep(0.1)
    expect(UserModuleLinker.where(user: @user).count).to eq 1
  end

  def then_they_should_be_able_to_see_the_module_under_the_my_modules_section
    my_modules = find('#my_modules')
    expect(my_modules).to have_content "Test Module"
  end

  def then_they_should_not_be_able_to_see_the_module_under_the_other_modules_section
    other_modules = find('#other_modules')
    expect(other_modules).to_not have_content "Test Module"
  end

end
