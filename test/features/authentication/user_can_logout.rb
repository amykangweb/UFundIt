require "test_helper"

feature "Authentication::CanLogOut" do
  scenario "with a logged in user" do
    visit root_path
    click_link('Log in')
    fill_in 'Email', with: users(:one).email
    fill_in 'Password', with: 'password'
    click_button('Log in')
    page.text.must_include "Signed in successfully."
    click_link('Log out')
    page.text.must_include "Log in"
  end
end
