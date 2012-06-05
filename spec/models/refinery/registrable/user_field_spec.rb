require 'spec_helper'

module Refinery
  module Registrable
    describe UserField do
      it { should have_db_column(:id) }
      it { should have_db_column(:name) }
      it { should have_db_column(:type) }
      it { should have_db_column(:created_at) }
      it { should have_db_column(:updated_at) }

      it { should have_db_index(:id) }

      it { should have_many(:user_field_attributes) }
      it { should have_many(:user_field_validations) }
    end
  end
end
