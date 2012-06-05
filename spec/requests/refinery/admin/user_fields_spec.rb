require "spec_helper"

describe "manage user's profile fields" do
  login_refinery_superuser

  describe "new/create" do
    def visit_and_fill_form
      visit refinery.registrable_admin_user_fields_path
      click_link "Create new profile field"

      fill_in "Name", :with => "Occupation"
      select "Text", :from => "Type"

      click_button "Save"
    end

    it "can create a profile field" do
      visit_and_fill_form
      page.should have_content("'Occupation' was successfully added.")
    end
  end

  describe "edit/update" do
    before(:all) { FactoryGirl.create(:user_text_field, :name => 'Occupation') }

    def visit_and_fill_form
      visit refinery.registrable_admin_user_fields_path
      click_link "Application_edit"

      fill_in "Name", :with => "Hobby"

      click_button "Save"

    end

    it 'can update a profile field' do
      visit_and_fill_form
      page.should have_content("'Hobby' was successfully updated.")
    end
  end

  describe "destroy" do
    before(:all) { FactoryGirl.create(:user_text_field, :name => 'Hobby') }
    it 'can destroy a profile field' do
      visit refinery.registrable_admin_user_fields_path
      click_link "Delete"

      page.should have_content("'Hobby' was successfully removed.")
    end
  end
end
