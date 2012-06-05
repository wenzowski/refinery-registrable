require "spec_helper"

module Refinery
  describe 'user registration' do
    before(:each) do
      FactoryGirl.create(:refinery_user)
    end
    let(:registrable_user) { FactoryGirl.create(:registrable_user) }

    describe 'when I am not logged in' do
      it 'allows user creation' do
        user_count = User.count

        # Verify that we can access the sign up page.
        visit refinery.new_registrable_registration_path
        page.should have_content("Register")

        # Fill in user details.
        fill_in 'Username', :with => 'rspec'
        fill_in 'Email', :with => 'rspec@example.com'
        fill_in 'Password', :with => 'spectacular'
        fill_in 'Password confirmation', :with => 'spectacular'

        # Sign up and verify!
        click_button 'Sign up'
        page.should have_content('Welcome to Refinery, rspec.')
        User.count.should == user_count + 1
      end

      it 'does not allow me to see my profile' do
        visit refinery.registrable_registration_path(registrable_user)
        page.should have_content('Hello! Please sign in.')
      end

      it 'does not allow me to edit my profile' do
        visit refinery.edit_registrable_registration_path(registrable_user)
        page.should have_content('Hello! Please sign in.')
      end

      it 'does not allow me to update my profile'
      it 'does not allow me to delete my account'
    end

    describe 'when I am logged in' do
      def login_user
        visit refinery.new_refinery_user_session_path

        fill_in "Login", :with => registrable_user.username
        fill_in "Password", :with => registrable_user.password

        click_button "Sign in"
      end

      it 'allows me to see my profile' do
        login_user
        visit refinery.registrable_registration_path(registrable_user)
        page.should have_content('Your Profile')
        page.should have_content('Edit')
        page.should have_content('Logout')
      end

      it "does not allow me to see other users' profiles" do
        other_user = FactoryGirl.create(:registrable_user)
        login_user
        visit refinery.registrable_registration_path(other_user)
        page.should have_content("Sorry #{registrable_user.username}, you only have access to your own profile.")
      end

      it 'allows me to edit/update my profile' do
        login_user
        visit refinery.edit_registrable_registration_path(registrable_user)
        fill_in 'Username', :with => "longer#{registrable_user.username}"
        fill_in 'Email', :with => "longer#{registrable_user.email}"
        click_button 'Update'
        page.should have_content('Your Profile')
        page.should have_content('Your profile was successfully updated.')
        # page.should have_content("longer#{registrable_user.username}")
        # page.should have_content("longer#{registrable_user.email}")
      end

      # Cancel is currently broken if the user arrives directly on the edit page.
      it 'allows me to cancel out of my profile edits without saving' do
        login_user
        visit refinery.registrable_registration_path(registrable_user)
        click_link 'Edit'
        fill_in 'Username', :with => "longer#{registrable_user.username}"
        fill_in 'Email', :with => "longer#{registrable_user.email}"
        click_link 'Cancel'
        page.should have_content('Your Profile')
        page.should_not have_content('Your profile was successfully updated.')
        # page.should have_content(registrable_user.username)
        # page.should have_content(registrable_user.email)
      end

      it 'allows me to delete my account'
    end
  end
end
