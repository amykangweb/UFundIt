require "test_helper"

feature "Authentication::ProfilePage" do
  scenario "with an owner and committer" do
    sign_in(:joe)
    visit root_path
    click_link('View User Profile')
    page.text.must_include users(:joe).name
    #in deals sponsored list:
    page.text.must_include deals(:seahawks).name
    #in deals committed to list:
    page.text.must_include deals(:widgets).name
  end

  scenario "with an owner and non-committer" do
    sign_in(:jeff)
    visit root_path
    click_link('View User Profile')
    page.text.must_include users(:jeff).name
    #in deals sponsored list:
    page.text.must_include deals(:widgets).name
    #in deals committed to list:
    page.text.must_include "No deal commitments. Browse Deals."
  end

  scenario "with a committer and non-owner" do
    sign_in(:jane)
    visit root_path
    click_link('View User Profile')
    page.text.must_include users(:jane).name
    #in deals sponsored list:
    page.text.must_include "No sponsored deals. Add a Deal."
    #in deals committed to list:
    page.text.must_include deals(:widgets).name
  end

  scenario "with a generic users" do
    sign_in(:user)
    visit root_path
    click_link('View User Profile')
    page.text.must_include users(:user).name
    #in deals sponsored list:
    page.text.must_include "No sponsored deals. Add a Deal."
    #in deals committed to list:
    page.text.must_include "No deal commitments. Browse Deals."
  end
end


