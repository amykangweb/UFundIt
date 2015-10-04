require "test_helper"

feature "Creating account" do
  before :each do
    visit root_path
    click_link('Sign Up')
  end

  scenario "with valid content is successful" do
    fill_in "Name", with: "Person"
    fill_in 'Email', with: "new@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button('Sign Up')
    page.text.must_include "You have signed up successfully"
  end

  scenario "without a valid formatted email returns error" do
    fill_in "Name", with: "Person"
    fill_in 'Email', with: "user@example"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button('Sign Up')
    page.text.must_include "Email is invalid"
  end

  scenario "without a valid password returns error" do
    fill_in "Name", with: "Person"
    fill_in 'Email', with: "user@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "notmatching"
    click_button('Sign Up')
    page.text.must_include "Password confirmation doesn't match Password"
  end

  scenario "without a name returns error" do
    fill_in "Name", with: ""
    fill_in 'Email', with: "new@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button('Sign Up')
    page.text.must_include "Name can't be blank"
  end

  scenario "without a unique name returns error" do
    fill_in "Name", with: "Joe User"
    fill_in 'Email', with: "new@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button('Sign Up')
    page.text.must_include "Name has already been taken"
  end
end
