require "test_helper"
# visitors can't delete deals
# only admin can delete deals
feature "Deleting a deal" do
  scenario "is not allowed when it is published" do
    sign_in(:jeff)
    click_link "Profile"
    page.text.wont_include "Destroy"
    click_link "Widgets"
    within(".control") do
      page.text.wont_include "Destroy"
    end
  end
end
