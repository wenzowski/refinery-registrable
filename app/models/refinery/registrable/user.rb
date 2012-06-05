module Refinery
  module Registrable
    class User < ::Refinery::User
      attr_accessible :user_field_attributes
      has_many :user_field_attributes
      accepts_nested_attributes_for :user_field_attributes

      def fields
        UserField.all
      end

      def self_register
        if valid?
          # first we need to save user
          save
          # add roles
          ::Refinery::Registrable.roles.each do |role|
            add_role(role)
          end
          # add plugins
          # self.plugins = Refinery::Plugins.registered.in_menu.names
        end
      end

      def title
        username
      end

    end
  end
end
