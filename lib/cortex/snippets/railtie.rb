module Cortex
  module Snippets
    class Railtie < Rails::Railtie
      initializer 'cortex.snippets.view_helpers' do
        ActiveSupport.on_load( :action_view ){ include ViewHelpers }
      end
    end
  end
end
