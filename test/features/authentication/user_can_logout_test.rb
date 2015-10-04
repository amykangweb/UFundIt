require "test_helper"

feature "Authentication::CanLogOut" do
  scenario "with a logged in user" do
    visit root_path
    click_link('Log In')
    fill_in 'Email', with: users(:joe).email
    fill_in 'Password', with: 'password'
    click_button('Log In')
    page.text.must_include "Signed in successfully."
    click_link('Sign Out')
    page.text.must_include "Log In"
  end
end
