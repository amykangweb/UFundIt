require "test_helper"
# deal creators can edit deals until they submit for publication
# only the deal creator or admin can edit the page (until its published)
# page cannot be edited or deleted after publication (only by admin)
feature "Editing a deal" do
  scenario "is not allowed when it is published" do
    sign_in(:jeff)
    click_link "Profile"
    click_link "Show"
    page.text.wont_include "Edit"
  end
end
