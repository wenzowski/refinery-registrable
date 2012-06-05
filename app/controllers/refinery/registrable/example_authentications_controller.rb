module Refinery
  module Registrable
    class ExampleAuthenticationsController < ::ApplicationController

      helper Refinery::Core::Engine.helpers
      layout 'refinery/layouts/login'

      before_filter :authenticate_refinery_user!, :only => [:index, :user_dashboard]
      after_filter :redirect_to_dashboard, :only => :register_or_login

      def index
      end

      def register_or_login
      end

      def user_dashboard
      end

      private

      def redirect_to_dashboard
        session[:refinery_user_return_to] = refinery.user_dashboard_registrable_example_authentications_path
      end

    end
  end
end
