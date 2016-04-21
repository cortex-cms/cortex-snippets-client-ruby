require 'cortex/snippets/client/helper'
require 'cortex/snippets/client/railtie' if defined?(Rails)
require 'cortex-client'
require 'connection_pool'
require 'addressable/template'

module Cortex
  module Snippets
    module Client
      class << self
        def cortex_client
          if ENV['CORTEX_SNIPPET_ACCESS_TOKEN'].nil? || ENV['CORTEX_SNIPPET_ACCESS_TOKEN'].empty?
            @cortex_client ||= ConnectionPool::Wrapper.new(size: 5, timeout: 3) { Cortex::Client.new(key: ENV['CORTEX_SNIPPET_KEY'], secret: ENV['CORTEX_SNIPPET_SECRET'], base_url: ENV['CORTEX_SNIPPET_BASE_URL'], scopes: ENV['CORTEX_SNIPPET_SCOPES']) }
          else
            @cortex_client ||= ConnectionPool::Wrapper.new(size: 5, timeout: 3) { Cortex::Client.new(access_token: ENV['CORTEX_SNIPPET_ACCESS_TOKEN']) }
          end
        end

        def current_webpage(request)
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
