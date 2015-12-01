module Cortex
  module Snippets
    module Client
      class Railtie < Rails::Railtie
        initializer 'cortex.snippets.client.view_helpers' do
          ActiveSupport.on_load( :action_view ){ include ViewHelpers }
        end
      end
    end
  end
end
