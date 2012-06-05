require "spec_helper"

module Refinery
  describe 'redirects' do
    let(:protected_path) { refinery.registrable_example_authentications_path }
    let(:login_path) { refinery.new_refinery_user_session_path }

    before(:each) do
      FactoryGirl.create(:refinery_user,
        :username => "ugisozols",
        :password => "123456",
        :password_confirmation => "123456"
      )
    end

    context "when visiting a protected path" do
      before(:each) { visit protected_path }

      it "redirects to the login" do
        current_path.should == login_path
      end

      it "shows login form" do
        page.should have_content("Hello! Please sign in.")
        page.should have_content("I forgot my password")
        page.should have_selector("a[href*='/refinery/users/password/new']")
      end

      it "redirects to the protected path on login" do
        fill_in "Login", :with => "ugisozols"
        fill_in "Password", :with => "123456"
        page.click_button "Sign in"
        current_path.should == protected_path
      end
    end
  end

  describe "register or login" do
    let(:register_or_login_path) { refinery.register_or_login_registrable_example_authentications_path }
    let(:dashboard_path) { refinery.user_dashboard_registrable_example_authentications_path }

    before(:each) do
      FactoryGirl.create(:refinery_user)
    end

    context "when the user is not registered" do
      before(:each) { visit register_or_login_path }

      it "prompts the user to register" do
        page.should have_content("Register")
      end

      it "registers the user and redirects to the dashboard path" do
        click_link "Register"
        fill_in "Username", :with => "test"
        fill_in "Email", :with => "test@test.test"
        fill_in "Password", :with => "password"
        fill_in "Password confirmation", :with => "password"
        click_button "Sign up"
        page.should have_content("Welcome to Refinery, test.")
        current_path.should == dashboard_path
      end
    end

    context "when the user is registered" do
      before(:each) do
        FactoryGirl.create(:user,
          :username => "rspec",
          :password => "password",
          :password_confirmation => "password"
        )
        visit register_or_login_path
      end

      it "prompts the user to login" do
        page.should have_content("Login")
      end

      it "shows login form" do
        click_link "Login"
        page.should have_content("Hello! Please sign in.")
        page.should have_content("I forgot my password")
        page.should have_selector("a[href*='/refinery/users/password/new']")
      end

      it "logs in user" do
        click_link "Login"
        fill_in "Login", :with => "rspec"
        fill_in "Password", :with => "password"
        click_button "Sign in"
        page.should have_content("Signed in successfully.")
        current_path.should == dashboard_path
      end
    end
  end
end
