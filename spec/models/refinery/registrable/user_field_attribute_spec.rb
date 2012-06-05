require 'spec_helper'

module Refinery
  module Registrable
    describe UserFieldAttribute do
      it { should have_db_column(:id) }
      it { should have_db_column(:user_id) }
      it { should have_db_column(:user_field_id) }
      it { should have_db_column(:value) }
      it { should have_db_column(:type) }
      it { should have_db_column(:created_at) }
      it { should have_db_column(:updated_at) }

      it { should have_db_index(:id) }
      it { should have_db_index(:user_id) }
      it { should have_db_index(:user_field_id) }
      it { should have_db_index(:type) }

      it { should belong_to(:user) }
      it { should belong_to(:user_field) }
    end
  end
end
