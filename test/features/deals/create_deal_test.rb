require 'test_helper'

feature 'Create A Deal' do
  scenario 'logged in user can create a deal' do
    visit deals_path
    click_on "Create a Deal"
    fill_in "Title", with: "Deal Title"
    fill_in "Description", with: "Deal Description"
    click_on "Preview Deal"
    page.text.must_include "Deal successfully created"
    page.text.must_include "Deal Title"
  end

  scenario 'visitor must log in to create a deal' do
    #fill in
  end
end
