require "test_helper"

feature "Profile page" do
  scenario "shows account settings link" do
    sign_in(:joe)
    visit root_path
    click_link('My Profile')
    page.text.must_include 'Joe User'
    page.text.must_include 'Settings'
  end

  scenario "shows posted deals" do
    sign_in(:jeff)
    visit root_path
    click_link('My Profile')
    page.text.must_include 'Jeff User'
    page.text.must_include 'Widgets'
  end

  scenario "shows deals committed to" do
    sign_in(:jane)
    visit root_path
    click_link('My Profile')
    page.text.must_include 'Jane User'
    page.text.must_include 'Seahawks'
  end
end
