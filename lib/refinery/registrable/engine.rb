module Refinery
  module Registrable
    class Engine < Rails::Engine
      include Refinery::Engine

      isolate_namespace Refinery::Registrable

      initializer "register refinerycms_registrable plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = "refinerycms_registrable"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.registrable_admin_path }
          # plugin.menu_match = /refinery\/registrable\/?(courses|sessions|students|guardians)?/
          # plugin.activity = { :class_name => :'refinery/registrable/course' }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Registrable)
      end
    end
  end
end
