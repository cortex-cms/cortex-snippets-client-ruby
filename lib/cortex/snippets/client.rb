module Cortex
  module Snippets
    module Client
      class << self
        def cortex_client
          if ENV['CORTEX_SNIPPET_ACCESS_TOKEN'].nil? || ENV['CORTEX_SNIPPET_ACCESS_TOKEN'].empty?
            @cortex_client ||= ConnectionPool::Wrapper.new(size: 5, timeout: 3) { Cortex::Client.new(access_token: ENV['CORTEX_SNIPPET_ACCESS_TOKEN']) }
          else
            @cortex_client ||= ConnectionPool::Wrapper.new(size: 5, timeout: 3) { Cortex::Client.new(key: ENV['CORTEX_SNIPPET_KEY'], secret: ENV['CORTEX_SNIPPET_SECRET'], base_url: ENV['CORTEX_SNIPPET_BASE_URL']) }
          end
        end

        def current_webpage
          if defined?(Rails)
            Rails.cache.fetch("webpages/#{request_url}", expires_in: 30.minutes) do
              cortex_client.webpages.get_feed(request_url)
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
end
