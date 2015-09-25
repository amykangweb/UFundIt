require "test_helper"

feature "Authentication::ProfilePage" do
  scenario "with an owner and committer" do
    sign_in(:joe)
    visit root_path
    click_link('Profile')
    page.text.must_include 'Joe User'
    page.text.must_include 'Reset Password'

    #in deals sponsored list:
    page.text.must_include 'Seahawks'
    #in deals committed to list:
    page.text.must_include 'Widgets'
  end

  scenario "with an owner and non-committer" do
    sign_in(:jeff)
    visit root_path
    click_link('Profile')
    page.text.must_include 'Jeff User'
    #in deals sponsored list:
    page.text.must_include 'Widgets'
    #in deals committed to list:
    page.text.must_include "0 deals committed to"
  end

  scenario "with a committer and non-owner" do
    sign_in(:jane)
    visit root_path
    click_link('Profile')
    page.text.must_include 'Jane User'
    #in deals sponsored list:
    page.text.must_include "No sponsored deals."
    #in deals committed to list:
    page.text.must_include 'Seahawks'
  end

  scenario "with a generic users" do
    sign_in(:user)
    visit root_path
    click_link('Profile')
    page.text.must_include 'Jose User'
    #in deals sponsored list:
    page.text.must_include "No sponsored deals."
    #in deals committed to list:
    page.text.must_include "No deal commitments."
  end
end


