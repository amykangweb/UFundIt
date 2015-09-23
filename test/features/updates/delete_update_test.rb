require "test_helper"

feature "Deleting an update" do
  scenario "returns success message" do
    sign_in(:jeff)
    click_link "Widgets"
    click_link "Destroy"
    page.text.must_include "Update was successfully destroyed."
  end

  scenario "link is not shown to unsigned in users" do
    visit root_path
    click_link "Widgets"
    page.text.wont_include "Destroy"
  end

  scenario "link is not shown to other owners" do
    sign_in(:joe)
    click_link "Widgets"
    page.text.wont_include "Destroy"
  end
end
