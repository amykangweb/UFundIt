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
end
