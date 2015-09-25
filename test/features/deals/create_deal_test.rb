require 'test_helper'

feature 'Create A Deal' do
  scenario 'logged in user can create a deal' do
    sign_in
    click_on "New Deal"
    fill_in "Title", with: deals(:widgets).title
    # page.attach_file('deal[image]', Rails.root + 'test/fixtures/cat.jpg')
    fill_in "Description", with: deals(:widgets).description
    fill_in "Goal", with: deals(:widgets).goal
    fill_in "Location", with: deals(:widgets).location
    fill_in "Amount", with: deals(:widgets).amount
    click_button "Preview / Publish"
    page.text.must_include "Deal was successfully created"
    page.text.must_include "Widgets"
    # page.find('#deal-image')['src'].must_include 'cat.jpg'
  end

  scenario 'visitor must log in to create a deal' do
    visit deals_path
    click_on "New Deal"
    page.text.must_include "You need to sign in or sign up before continuing."
  end

  scenario 'deal creator can publish' do
    sign_in
    visit deals_path
    click_on "New Deal"
    fill_in "Title", with: deals(:widgets).title
    # page.attach_file('deal[image]', Rails.root + 'test/fixtures/cat.jpg')
    fill_in "Description", with: deals(:widgets).description
    fill_in "Goal", with: deals(:widgets).goal
    fill_in "Location", with: deals(:widgets).location
    fill_in "Amount", with: deals(:widgets).amount
    click_on "Preview / Publish"
    page.text.must_include "Deal was successfully created"
    page.text.must_include "Widgets"
    page.text.must_include "This Deal is Not Yet Published!"
    first(:link, "Edit").click
    check "Published?"
    click_on "Preview / Publish"
    page.text.must_include "Deal was successfully updated."
    page.text.wont_include "This Deal is Not Yet Published!"
  end

  scenario 'public deals get added to index page' do
    sign_in
    visit deals_path
    click_on "New Deal"
    fill_in "Title", with: deals(:widgets).title
    # page.attach_file('deal[image]', Rails.root + 'test/fixtures/cat.jpg')
    fill_in "Description", with: deals(:widgets).description
    fill_in "Goal", with: deals(:widgets).goal
    fill_in "Location", with: deals(:widgets).location
    fill_in "Amount", with: deals(:widgets).amount
    check "Published?"
    click_on "Preview / Publish"
    visit root_path
    page.text.must_include deals(:widgets).title
  end

  scenario 'private deals stay off the index page' do
    sign_in
    visit deals_path
    click_on "New Deal"
    fill_in "Title", with: "My private deal title"
    # page.attach_file('deal[image]', Rails.root + 'test/fixtures/cat.jpg')
    fill_in "Description", with: deals(:widgets).description
    fill_in "Goal", with: deals(:widgets).goal
    fill_in "Location", with: deals(:widgets).location
    fill_in "Amount", with: deals(:widgets).amount
    check "Private?"
    check "Published?"
    click_on "Preview / Publish"
    visit root_path
    page.text.wont_include "My private deal title"
  end

end
