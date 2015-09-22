require "test_helper"

feature "Authentication::CanLogin" do
  before :each do
    visit root_path
    click_link('Log in')
  end

  scenario "with a valid login" do
    fill_in 'Email', with: users(:one).email
    fill_in 'Password', with: 'password'
    click_button('Log in')
    page.text.must_include "Signed in successfully."
  end

  scenario "without valid user email" do
    fill_in 'Email', with: "notauser@example.com"
    fill_in 'Password', with: "password"
    click_button('Log in')
    page.text.must_include "Invalid email or password."
  end

  scenario "with a valid email but not a valid password" do
    fill_in 'Email', with: users(:one).email
    fill_in 'Password', with: "wrongpassword"
    click_button('Log in')
    page.text.must_include "Invalid email or password."
  end
end
