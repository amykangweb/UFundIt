require "test_helper"

feature "Search Form" do

  scenario "user can flag a deal for admin review" do
    skip
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Flag this deal for admin review"
    page.text.must_include "An admin will review this listing to make sure it confirms with the Terms of Service."
    assert_equal deal.flag, true
  end

  scenario "admin can see and review flagged deals on index page" do
    skip
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Flag this deal for admin review"
    assert_equal deal.flag, true
    sign_in(:admin)
    page.text.must_include "Admin Alert"
    click_on "Unflag"
    assert_equal deal.flag, false
  end

  scenario "user can flag a deal that has already been flagged" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Flag this deal for admin review"
    visit deal_path(deal.id)
    click_on "Flag this deal for admin review"
    page.text.must_include "Thanks for the heads up. This listing has already been reported."
  end
end
