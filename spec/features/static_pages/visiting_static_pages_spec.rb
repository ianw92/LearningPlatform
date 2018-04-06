require "rails_helper"

feature 'Visiting pages' do
  scenario "Visiting static page that exists" do
    given_a_signed_in_user
    when_they_visit_the_timetable_page
    then_the_timetable_page_is_rendered
  end

  scenario "Visiting static page that exists" do
    given_a_signed_in_user
    when_they_visit_an_invalid_page
    then_the_404_page_is_rendered
  end

  # Scenario 1

  def given_a_signed_in_user
    @user = create(:user)
    login_as(@user)
  end

  def when_they_visit_the_timetable_page
    visit '/pages/timetable'
  end

  def then_the_timetable_page_is_rendered
    expect(page).to have_content 'My Timetable'
  end

  # Scenario 2

  def when_they_visit_an_invalid_page
    visit '/pages/invalid'
  end

  def then_the_404_page_is_rendered
    expect(page).to have_content "The page you were looking for doesn't exist"
  end

end
