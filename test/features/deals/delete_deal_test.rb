require "test_helper"
# visitors can't delete deals
# only admin can delete deals
feature "Deleting a deal" do
  scenario "is not allowed when it is published" do
    sign_in(:jeff)
    click_link "My Profile"
    click_link "Widgets"
    within ".control" do
      refute_content "Destroy"
    end
  end
end
