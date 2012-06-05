require 'spec_helper'

module Refinery
  module Registrable
    describe User do
      it { should have_many(:user_field_attributes) }
    end
  end
end
