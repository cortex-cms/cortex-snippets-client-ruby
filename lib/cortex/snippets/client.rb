module Cortex
  module Snippets
    class Client
      attr_accessor :current_webpage

      def initialize(hasharg)
        if hasharg.has_key? :access_token
          @cortex_client = ConnectionPool::Wrapper.new(size: 5, timeout: 3) { Cortex::Client.new(access_token: hasharg[:access_token]) }
        else
          @cortex_client = ConnectionPool::Wrapper.new(size: 5, timeout: 3) { Cortex::Client.new(key: hasharg[:key], secret: hasharg[:secret], base_url: hasharg[:base_url]) }
        end
      end

      def current_webpage
        if defined?(Rails)
          Rails.cache.fetch("webpages/#{request_url}", expires_in: 30.minutes) do
            @cortex_client.webpages.get_feed(request_url)
          end
        else
          raise 'Your Web framework is not supported. Supported frameworks: Rails'
        end
      end

      private

      def request_url
        # TODO: Should be turbo-easy to grab request URL from Rack, but this is fine for now
        request.original_url
      end
    end
  end
end
