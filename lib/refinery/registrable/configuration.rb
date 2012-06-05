module Refinery
  module Registrable
    ##
    # Each symbol in self.roles corresponds to a Refinery::Role stored in the
    # database. If the Refinery::Role does not exist when it is added to this
    # list it will be created. Deleting rather than disabling roles may cause
    # issues with the user_roles join table, so disabling is advised where
    # possible.
    ##
    include ActiveSupport::Configurable
    config_accessor :roles, :enabled

    self.enabled  = true
    self.roles    = [:self_registered]

    class << self
      def roles=(r)
        if r.class == Array
          (roles - r).each do |remove|
            disable_role!(remove)
          end
          (r - roles).each do |add|
            ensure_role_enabled!(add)
          end
        else
          ensure_role_enabled!(r)
        end
      end

      def ensure_role_enabled!(r)
        r = enforce_symbol(r)
        add_role!(r) unless role_enabled?(r)
      end

      def role_enabled?(r)
        r = enforce_symbol(r)
        roles.include? r
      end

      def disable_role!(r)
        r = enforce_symbol(r)
        roles.delete r
      end

      def add_role!(r)
        r = enforce_symbol(r)
        # Refinery::Role[r]
        roles << r
      end

      def delete_role!(r)
        r = enforce_symbol(r)
        disable_role!(r)
        Refinery::Role[r].destroy
      end

      def ensure_roles_enabled!(r_array)
        enforce_array(r_array)
        r_array.each {|r| ensure_role_enabled!(r) }
      end

      private

      def enforce_symbol(input)
        case input
          when Symbol then return input
          when String then return input.underscore.to_sym
          when Refinery::Role then return input.title.underscore.to_sym
          else raise TypeError
        end
      end

      def enforce_array(input)
        raise TypeError unless input.kind_of? Array
      end
    end

  end
end
