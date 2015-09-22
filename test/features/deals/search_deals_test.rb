require "test_helper"

feature "Search Form" do
  scenario "returns correct results" do
    visit root_path
    fill_in "search", with: "Widgets"
    click_on "Search"
    page.text.must_include "Widgets"
    page.text.wont_include "Seahawks Suite for Panthers Game"
  end
end
