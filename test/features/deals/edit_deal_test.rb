require "test_helper"
# deal creators can edit deals until they submit for publication
# only the deal creator or admin can edit the page (until its published)
# page cannot be edited or deleted after publication (only by admin)
feature "Editing a deal" do
  scenario "edit link is not shown when published" do
    sign_in(:jeff)
    click_link "Profile"
    click_link "Widgets"
    page.text.wont_include "Edit Deal"
  end

  scenario "is not allowed to visitors" do
    visit edit_deal_path(1)
    page.text.must_include "You need to sign in or sign up before continuing."
  end

  scenario "is not allowed to owner when deal is published" do
    sign_in(:jeff)
    visit edit_deal_path(1)
    page.text.must_include "You are not authorized to perform this action."
  end

  scenario "is allowed to admin even when published" do
    sign_in(:admin)
    visit edit_deal_path(1)
    page.text.must_include "Editing Deal"
    fill_in "Title", with: "Edited Title"
    click_on "Preview / Publish"
    page.text.must_include "Deal was successfully updated."
  end

  scenario "owner can edit deal before published" do
    sign_in(:jeff)
    click_on "New Deal"
    fill_in "Title", with: "My new deal"
    page.attach_file('deal[image]', Rails.root + 'test/fixtures/cat.jpg')
    fill_in "Description", with: deals(:widgets).description
    fill_in "Goal", with: deals(:widgets).goal
    fill_in "Location", with: deals(:widgets).location
    fill_in "Amount", with: deals(:widgets).amount
    click_button "Preview / Publish"
    first(:link, "Edit").click
    fill_in "Title", with: "Amazing Toaster Oven"
    check "Published?"
    click_on "Preview / Publish"
    page.text.must_include "Deal was successfully updated."
    page.text.wont_include "This Deal is Not Yet Published!"
    page.text.must_include "Amazing Toaster Oven"
    page.text.wont_include "My new deal"
  end

  scenario "owner can save a draft and come back to edit unpublished later" do
    sign_in(:jeff)
    click_on "New Deal"
    fill_in "Title", with: "My new deal"
    page.attach_file('deal[image]', Rails.root + 'test/fixtures/cat.jpg')
    fill_in "Description", with: deals(:widgets).description
    fill_in "Goal", with: deals(:widgets).goal
    fill_in "Location", with: deals(:widgets).location
    fill_in "Amount", with: deals(:widgets).amount
    click_button "Preview / Publish"
    click_link('Sign Out')
    sign_in(:jeff)
    click_on "My Profile"
    click_on "My new deal"
    first(:link, "Edit").click
    check "Published?"
    click_on "Preview / Publish"
    page.text.must_include "Deal was successfully updated."
    page.text.wont_include "This Deal is Not Yet Published!"
  end
end
