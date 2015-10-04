require "test_helper"

feature "Flagging deal" do

  scenario "returns notice" do
    skip
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Flag"
    page.text.must_include "An admin will review this listing to make sure it confirms with the Terms of Service."
    assert_equal deal.flag, true
  end

  scenario "shows flagged deal on index page for admin" do
    skip
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Flag"
    assert_equal deal.flag, true
    sign_in(:admin)
    page.text.must_include "Admin Alert"
    click_on "Unflag"
    assert_equal deal.flag, false
  end

  scenario "returns notice deal has been flagged" do
    deal = deals(:widgets)
    visit deal_path(deal.id)
    click_on "Flag"
    visit deal_path(deal.id)
    click_on "Flag"
    page.text.must_include "Thanks for the heads up. This listing has already been reported."
  end
end
