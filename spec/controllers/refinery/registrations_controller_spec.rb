require "spec_helper"

describe Refinery::Registrable::RegistrationsController do
  before(:each) { FactoryGirl.create(:refinery_user) }
  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    it "renders the new template" do
      get :new
      response.should be_success
      response.should render_template("refinery/registrable/registrations/new")
    end
  end

  describe "#create" do
    it "creates a new user with valid params" do
      user = Refinery::Registrable::User.new(
        :username => "bob",
        :email => "bob@bob.bob",
        :password => "bobbitybobbob",
        :password_confirmation => "bobbitybobbob"
      )
      user.should_receive(:save).twice{ true }
      Refinery::Registrable::User.should_receive(:new).once.with(instance_of(HashWithIndifferentAccess)){ user }
      post :create, :user => {}
      response.should be_redirect
    end

    it "re-renders #new if there are errors" do
      user = Refinery::Registrable::User.new :username => "bob"
      user.should_not_receive(:save)
      Refinery::Registrable::User.should_receive(:new).once.with(instance_of(HashWithIndifferentAccess)){ user }
      post :create, :user => {}
      response.should be_success
      response.should render_template("refinery/registrable/registrations/new")
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      sign_in user
      get :edit, :id => user.id
      response.should be_success
      response.should render_template("refinery/registrable/registrations/edit")
    end
  end

  describe "#update" do
    it "updates a user" do
      Refinery::User.should_receive(:find).at_least(1).times{ user }
      put "update", :id => user.id.to_s, :user => {}
      response.should be_redirect
    end
  end
end