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
            Rails.cache.fetch("webpages/#{request_url(request)}", expires_in: 0, race_condition_ttl: 10) do
              cortex_client.webpages.get_feed(request_url(request)).contents
            end
          else
            raise 'Your Web framework is not supported. Supported frameworks: Rails'
          end
        end

        def request_url(request)
          # TODO: Should be grabbing request URL in a framework-agnostic manner, but this is fine for now
          uri = Addressable::URI.parse(request.original_url)
          path = uri.path == "/" ? uri.path : uri.path.chomp("/")
          "#{uri.scheme}://#{uri.authority}#{path}"
        end
      end
    end
  end
end
