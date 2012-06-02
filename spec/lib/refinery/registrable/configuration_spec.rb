require 'spec_helper'

module Refinery
  describe Registrable
    it 'should know when registration is enabled and disabled'
    it 'should have registration enabled by default'

    it 'should know which roles a user may register with'

    it 'should be able to manipulate registerable roles by string'
    it 'should be able to manipulate registerable roles by symbol'
    it 'should be able to manipulate registerable roles by Refinery::Role'

    describe '.ensure_roles' do
      it 'should enable all roles'
      it 'should be idempotent'
    end

    describe '.disable_role' do
      it 'should disable the role but not remove from the database'
    end

    describe '.delete_role' do
      it 'should disable the role and remove it from the database'
    end
  end
end
