module Refinery
  module Registrable
    class UsersController < Refinery::UsersController

      # Protect these actions behind an admin login
      # before_filter :redirect?, :only => [:new, :create]

      helper Refinery::Core::Engine.helpers
      layout 'refinery/layouts/login'

      crudify :'refinery/registrable/user'

      def create
        @user = User.new(params[:user])

        if @user.self_register
          flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe

          sign_in(@user)
          redirect_back_or_default(refinery.registerable_user_path(@user)) #####FIX THIS LINE######
        else
          render :new
        end
      end


      protected

      # def redirect?
      #   if refinery_user?
      #     redirect_to refinery.admin_users_path
      #   elsif refinery_users_exist?
      #     redirect_to refinery.new_refinery_user_session_path
      #   end
      # end
      #
      # def refinery_users_exist?
      #   Refinery::Role[:refinery].users.any?
      # end

    end
  end
end
