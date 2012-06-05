module Refinery
  module Registrable
    class UserField < Refinery::Core::BaseModel
      attr_accessible :name, :type

      has_many :user_field_attributes
      has_many :user_field_validations

      before_save :camelize

      # see http://blog.obiefernandez.com/content/2012/01/rendering-collections-of-heterogeneous-objects-in-rails-32.html
      # def to_partial_path
      #   "fields/#{self.class.name.underscore}"
      # end

      private

      def camelize
        self.type = self.type.camelize if self.type.respond_to?(:camelize)
      end

      # Dirty hack around a development dependency bug
      %w(text).each do |r|
        require_dependency "../../app/models/refinery/registrable/user_field/#{r}"
      end if Rails.env.development?
    end
  end
end
