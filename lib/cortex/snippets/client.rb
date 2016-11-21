require 'cortex/snippets/client/helper'
require 'cortex/snippets/client/railtie' if defined?(Rails)
require 'cortex-client'
require 'connection_pool'
require 'addressable/template'

module Cortex
  module Snippets
    module Client
      class << self
        def current_webpage(request, cortex_client)
          if defined?(Rails)
            sanitized_url = sanitized_webpage_url(request.original_url)
            Rails.cache.fetch("webpages/#{sanitized_url}", race_condition_ttl: 10) do
              cortex_client.webpages.get_feed(sanitized_url).contents
            end
          else
            raise 'Your Web framework is not supported. Supported frameworks: Rails'
          end
        end

        def sanitized_webpage_url(url)
          uri = Addressable::URI.parse(url)
          path = uri.path == '/' ? uri.path : uri.path.chomp('/')
          "#{uri.scheme}://#{uri.authority}#{path}"
        end
      end
    end
  end
end
