require 'test_helper'

feature 'Admin has full authority' do
  scenario 'Admin can see only UNpublished when link is clicked' do
    sign_in(:admin)
    visit '/'
    page.text.wont_include 'UnPublished active deals'
    page.text.wont_include 'These are the PUblished yet PRIVATE'
    page.text.wont_include 'These are the EXPIRED'

  end

  scenario 'Admin clicks Edit' do
    sign_in(:admin)
    visit deals_path
    click_on 'See the Unpublished'
    first(:link, 'Edit').click
    page.text.must_include 'Deal has been published!'
  end
end


