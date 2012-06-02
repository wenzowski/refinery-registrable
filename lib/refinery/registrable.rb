require 'refinerycms-core'
require 'refinerycms-settings'
require 'simple_form'

module Refinery
  autoload :RegistrableGenerator, 'generators/refinery/registrable_generator'

  module Registrable
    require 'refinery/registrable/engine'
    require 'refinery/registrable/configuration'

    autoload :Version, 'refinery/registrable/version'
    autoload :Tab, 'refinery/registrable/tabs'

    class << self
      attr_writer :root
      attr_writer :tabs

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def tabs
        @tabs ||= []
      end

      def version
        ::Refinery::Registrable::Version.to_s
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
