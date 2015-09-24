require "test_helper"

feature "Commitments::CommitingToADeal" do
  scenario "user can confirm commitment before being charged" do
    sign_in
    deal = deals(:widgets)
    visit deal_path(deal.id)
    page.text.must_include "Commit!"
    click_on "Commit!"
    page.text.must_include "Are you sure?"
    click_on "Commit!"
    page.text.must_include "Committed!"
    page.text.must_include users(:user).name
  end

  scenario "user can commit to a deal if goal is not met" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    page.text.must_include "Commit!"
  end

  scenario "user can't commit to a deal if goal is met" do
    skip
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
