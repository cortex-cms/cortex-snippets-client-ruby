require 'cortex/snippets/webpage'
require 'addressable/uri'

module Cortex
  module Snippets
    class Client
      include ActionView::Helpers::TagHelper

      def initialize(cortex_client)
        @cortex_client = cortex_client
      end

      def snippet(request, options = {}, block)
        snippets = current_webpage(request).snippets || []
        snippet = snippets.find { |snippet| snippet[:document][:name] == options[:id] }

        if snippet.nil? || snippet[:document][:body].nil?
          content_tag(:snippet, block, options)
        else
          content_tag(:snippet, snippet[:document][:body].html_safe, options)
        end
      end

      def current_webpage(request)
        if defined?(Rails)
          url = sanitized_webpage_url(request.original_url)
          Rails.cache.fetch("webpages/#{@cortex_client.access_token.client.id}/#{url}", race_condition_ttl: 10) do
            Cortex::Snippets::Webpage.new(@cortex_client, url, request.path)
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
