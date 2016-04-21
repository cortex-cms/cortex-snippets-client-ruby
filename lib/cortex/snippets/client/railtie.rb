module Cortex
  module Snippets
    module Client
      class Railtie < Rails::Railtie
        initializer 'cortex-snippets-client.view_controller_helpers' do |app|
          ActiveSupport.on_load :action_view do
            include Helper
          end

          ActiveSupport.on_load :action_controller do
            include Helper
          end
        end
      end
    end
  end
end
