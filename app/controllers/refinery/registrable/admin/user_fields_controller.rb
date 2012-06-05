module Refinery
  module Registrable
    module Admin
      class UserFieldsController < ::Refinery::AdminController

        crudify :'refinery/registrable/user_field',
                :title_attribute => 'name', :xhr_paging => true

      end
    end
  end
end
