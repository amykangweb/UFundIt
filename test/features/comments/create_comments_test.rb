require "test_helper"

feature "Creating comment" do
  scenario "is successful when user signed in" do
    sign_in
    deal = deals(:widgets)
    visit deal_path(deal.id)
    fill_in "Leave a comment:", with: "Comment Test"
    click_on "Create Comment"
    page.text.must_include "Comment Test"
  end

  scenario "is not successful when user is not signed in" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    fill_in "Leave a comment:", with: "Comment Test"
    click_on "Create Comment"
    page.text.must_include "You need to sign in or sign up before continuing."
  end

  scenario "is not successful when comment is blank" do
    sign_in
    deal = deals(:widgets)
    visit deal_path(deal.id)
    fill_in "Leave a comment:", with: ""
    click_on "Create Comment"
    page.text.must_include "Body can't be blank"
  end
end
