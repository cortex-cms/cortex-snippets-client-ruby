module Cortex
  module Snippets
    module ViewHelpers
      def snippet(options = {}, &block)
        snippet = webpage[:snippets].find { |snippet| snippet.name == options[:id] }

        if snippet.empty?
          content_tag(:snippet, capture(&block), id: options[:id])
        else
          content_tag(:snippet, snippet, id: options[:id])
        end
      end

      def seo_title
        webpage[:seo_title]
      end

      def seo_description
        webpage[:seo_description]
      end

      def noindex
        webpage[:noindex]
      end

      def nofollow
        webpage[:nofollow]
      end

      def noodp
        webpage[:noodp]
      end

      def nosnippet
        webpage[:nosnippet]
      end

      def noarchive
        webpage[:noarchive]
      end

      def noimageindex
        webpage[:noimageindex]
      end

      private

      def webpage
        Client::current_webpage(request)
      end
    end
  end
end
