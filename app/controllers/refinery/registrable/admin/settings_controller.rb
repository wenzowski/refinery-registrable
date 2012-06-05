module Refinery
  module Registrable
    module Admin
      class SettingsController < ::Refinery::AdminController

        def registrable
          enabled = Refinery::Registrable.toggle!
          unless request.xhr?
            redirect_back_or_default(refinery.registrable_admin_user_fields_path)
          else
            render :json => {:enabled => enabled},
                   :layout => false
          end
        end

      end
    end
  end
end
