module Refinery
  module Registrable
    class RegistrationsController < ::ApplicationController

      helper Refinery::Core::Engine.helpers
      layout 'refinery/layouts/login'

      before_filter :authenticate_current_user!, :only => [:show, :edit, :update, :destroy]

      crudify :'refinery/registrable/user'

      def show
        @user = User.find(params[:id])
      end

      def create
        @user = User.new(params[:user])

        if @user.self_register
          flash[:message] = "<h2>#{t('welcome', :scope => 'refinery.registrable.users.create', :who => @user.username).gsub(/\.$/, '')}.</h2>".html_safe

          sign_in(@user)
          redirect_user
        else
          render :new
        end
      end

      def update
        @user = User.find(params[:id])

        if @user.update_attributes(params[:user])
          flash[:message] = "<h2>#{t('success', :scope => 'refinery.registrable.users.update')}</h2>".html_safe
          redirect_to refinery.registrable_registration_path(@user)
        else
          render :edit
        end
      end

      private

      def redirect_user
        redirect_to(redirect_user_path)
      end

      def redirect_user_path
        session.delete(:refinery_user_return_to) || refinery.registrable_registration_path(@user)
      end

      def is_current_refinery_user?
        current_refinery_user.id == User.find(params[:id]).id
      end

      def authenticate_current_user!
        authenticate_refinery_user!
        unless is_current_refinery_user?
          flash[:error] = "<h2>#{t('profile_access_denied', :scope => 'refinery.registrable.users', :who => current_refinery_user.username).gsub(/\.$/, '')}.</h2>".html_safe
          redirect_to refinery.registrable_registration_path(current_refinery_user)
        end
      end
    end
  end
end
