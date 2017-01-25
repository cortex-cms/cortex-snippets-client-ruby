require 'cortex/snippets/client/webpage'
require 'addressable/uri'

module Cortex
  module Snippets
    class Client
      def initialize(cortex_client)
        @cortex_client = cortex_client
      end

      def snippet(options = {}, &block)
        snippets = current_webpage(@cortex_client)[:snippets] || []
        snippet = snippets.find { |snippet| snippet[:document][:name] == options[:id] }

        if snippet.nil? || snippet[:document][:body].nil? || snippet[:document][:body].empty?
          content_tag(:snippet, capture(&block), options)
        else
          content_tag(:snippet, snippet[:document][:body].html_safe, options)
        end
      end

      def current_webpage
        if defined?(Rails)
          url = sanitized_webpage_url(request.original_url)
          Rails.cache.fetch("webpages/#{@cortex_client.access_token.client.id}/#{url}", race_condition_ttl: 10) do
            Cortex::Snippets::Client::Webpage.new(@cortex_client, url)
          end
        else
          raise 'Your Web framework is not supported. Supported frameworks: Rails'
        end
      end

      private

      def sanitized_webpage_url(url)
        uri = Addressable::URI.parse(url)
        path = uri.path == '/' ? uri.path : uri.path.chomp('/')
        "#{uri.scheme}://#{uri.authority}#{path}"
      end
    end
  end
end
