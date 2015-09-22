require "test_helper"

feature "Authentication::CanCreateAccount" do
  before :each do
    visit root_path
    click_link('Sign up')
  end

  scenario "with valid content" do
    fill_in 'Email', with: "new@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button('Sign up')
    page.text.must_include "You have signed up successfully"
  end

  scenario "without a valid formatted email" do
    fill_in 'Email', with: "user@example"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button('Sign up')
    page.text.must_include "Email is invalid"
  end

  scenario "without a valid password" do
    fill_in 'Email', with: "user@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "notmatching"
    click_button('Sign up')
    page.text.must_include "Password confirmation doesn't match Password"
  end
end
