require "test_helper"

feature "Creating an update" do
  scenario "returns success message" do
    sign_in(:jeff)
    click_link "Widgets"
    click_link "Update"
    fill_in "Content", with: "My first update."
    click_on "Create Update"
    page.text.must_include "Update was successfully created."
    page.text.must_include "My first update."
  end

  scenario "is not allowed to unsigned in users" do
    visit new_deal_update_path(1, Update.new)
    page.text.must_include "You are not authorized to perform this action."
  end

  scenario "is not allowed to non deal owners" do
    sign_in(:joe)
    visit new_deal_update_path(1, Update.new)
    page.text.must_include "You are not authorized to perform this action."
  end
end
