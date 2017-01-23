require 'cortex/snippets/client/helper'
require 'cortex/snippets/client/railtie' if defined?(Rails)
require 'cortex-client'
require 'connection_pool'
require 'addressable/template'

module Cortex
  module Snippets
    class Client
      attr_reader :cortex_client

      def initialize(client)
        @cortex_client = client
      end
    end
  end
end
