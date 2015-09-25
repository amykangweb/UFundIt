require "test_helper"
# visitors can't delete deals
# only admin can delete deals
feature "Deleting a deal" do
  scenario "is not allowed when it is published" do
    sign_in(:jeff)
    click_link "View My Profile"
    click_link "Widgets"
    within "#owner-actions" do
      refute_content "Destroy"
    end
  end
end
