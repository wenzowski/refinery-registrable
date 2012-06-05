require 'spec_helper'

module Refinery
  module Registrable
    describe Engine do
      describe "plugin activity" do
        let(:activity) do
          Refinery::Plugins.registered.find_by_name("refinerycms_registrable").activity.first
        end

        it "sets the correct path for activity entries"
        # it "sets the correct path for activity entries" do
        #   activity.url.should eq("refinery.edit_registrable_admin_registration_path")
        # end
      end

      describe ".load_seed" do
        before (:all) { FactoryGirl.create(:refinery_user) }
        it "is idempotent" do
          Engine.load_seed
          Engine.load_seed

          Refinery::UserPlugin.where(:name => 'refinery_registrable').count.should == 1
          Refinery::Registrable.roles.each {|r|
            Refinery::Role.where(:title => r.to_s.camelcase).count.should eq(1)
          }
        end
      end
    end
  end
end
