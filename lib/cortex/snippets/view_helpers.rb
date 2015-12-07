module Cortex
  module Snippets
    module ViewHelpers
      def snippet(id)
        content_tag(:snippet, Client::current_webpage[:snippets].find { |snippet| snippet.name == id }, id: id)
      end

      def seo_title
        Client::current_webpage[:seo_title]
      end

      def seo_description
        Client::current_webpage[:seo_description]
      end

      def noindex
        Client::current_webpage[:noindex]
      end

      def nofollow
        Client::current_webpage[:nofollow]
      end

      def noodp
        Client::current_webpage[:noodp]
      end

      def nosnippet
        Client::current_webpage[:nosnippet]
      end

      def noarchive
        Client::current_webpage[:noarchive]
      end

      def noimageindex
        Client::current_webpage[:noimageindex]
      end
    end
  end
end
