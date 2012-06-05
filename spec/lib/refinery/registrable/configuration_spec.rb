require 'spec_helper'

module Refinery
  describe Registrable do

    it 'should have registration enabled by default' do
      subject.enabled.should be_true
    end

    context 'should know when registration is disabled' do
      before { subject.enabled = false }
      specify { subject.enabled.should be_false }
    end

    context 'invalid role names' do
      specify {
        lambda { subject.ensure_role_enabled!(1337) }.should raise_error(TypeError)
      }
    end

    context 'valid role names' do
      specify {
        lambda { subject.ensure_role_enabled!('1337') }.should_not raise_error(TypeError)
      }
      specify {
        lambda{ subject.ensure_role_enabled!(:'1337') }.should_not raise_error(TypeError)
      }
      specify {
        lambda{subject.ensure_role_enabled!(Refinery::Role[1337])}.should_not raise_error(TypeError)
      }
    end


    specify { subject.role_enabled?(:non_existent).should be_false }
    context 'should return true if a user may register with this role' do
      before { subject.ensure_role_enabled!(:valid) }
      specify { subject.role_enabled?(:valid).should be_true }
    end

    describe '.ensure_roles' do
      let(:available_roles) {
        ['one_role', 'TwoRole', Refinery::Role[:red_role], :blue_role ]
      }
      before {
        subject.ensure_roles_enabled! available_roles
      }
      it 'should enable all roles' do
        %w( one_role two_role red_role blue_role).each {|r|
          subject.role_enabled?(r).should be_true
        }
      end
      it 'should be idempotent' do
        count = subject.roles.count
        subject.ensure_roles_enabled! available_roles
        subject.ensure_roles_enabled! available_roles
        subject.roles.count.should be == count
      end
    end

    describe 'disable and delete similar except delete also removes role from db' do
      before(:each) {
        subject.ensure_role_enabled!(:valid)
        Refinery::Role[:valid]
      }
      specify {
        subject.disable_role!(:valid)
        subject.role_enabled?(:valid).should be_false
      }
      specify {
        Refinery::Role.find_by_title(:valid.to_s.camelize).class.should be == Refinery::Role
        subject.delete_role!(:valid)
        subject.role_enabled?(:valid).should be_false
        Refinery::Role.find_by_title(:valid.to_s.camelize).should be_nil
      }
    end

  end
end
