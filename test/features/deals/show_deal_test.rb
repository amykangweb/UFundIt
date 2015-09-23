require "test_helper"

feature "Deals::ShowADeal" do
  scenario "anyone can view deals" do
    visit root_path
    page.must_have_content "Listing Deals"
  end

  scenario "anyone can see list of who is supporting a deal" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    # possibly make so only logged in can see supporters, but anyone can see progress towards goal.
    page.must_have_content users(:joe).name # joe is supporting widgets
  end

  scenario "anyone can see how many commitments a deal needs to reach goal" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    page.text.must_include "Progress to Goal: #{deal.users.count} out of #{deal.goal}"
  end

  scenario "click an owner name to see their profile page" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Jeff User"
    page.text.must_include deals(:widgets).title
  end
end
