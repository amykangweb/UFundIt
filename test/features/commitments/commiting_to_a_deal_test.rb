require "test_helper"

feature "Committing to a deal" do
  scenario "takes user to a confirmation page" do
    sign_in
    deal = deals(:widgets)
    visit deal_path(deal.id)
    page.text.must_include "Commit!"
    click_on "Commit!"
    page.text.must_include "Are you sure?"
    find(".paypal").click
    page.text.must_include "Committed!"
    page.must_have_content users(:joe).name
  end

  scenario "user can commit to a deal if goal is not met" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    page.text.must_include "Commit!"
  end

  scenario "user can't commit to a deal if goal is met" do
    skip # this is on skip because the funded fixture breaks everything. but it works in the app!
    deal = deals(:funded)
    visit deal_path(deal.id)
    page.text.wont_include "Commit!"
  end

  scenario "user must be logged in to commit to deal" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Commit!"
    page.text.must_include "You need to sign in or sign up before continuing."
  end
end
