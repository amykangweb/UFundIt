require "test_helper"

feature "Editing an update" do
  scenario "returns success message" do
    sign_in(:jeff)
    click_link "Widgets"
    click_link "Edit"
    fill_in "Content", with: "My first update. Edit."
    click_on "Update Update"
    page.text.must_include "Update was successfully updated."
    page.text.must_include "My first update. Edit."
  end

  scenario "is not allowed to unsigned in users" do
    visit edit_deal_update_path(1, updates(:one))
    page.text.must_include "You are not authorized to perform this action."
  end

  scenario "is not allowed to non deal owners" do
    sign_in(:joe)
    visit edit_deal_update_path(1, updates(:one))
    page.text.must_include "You are not authorized to perform this action."
  end
end
