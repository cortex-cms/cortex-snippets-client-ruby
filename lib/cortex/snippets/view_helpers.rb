module Cortex
  module Snippets
    module ViewHelpers
      def snippet(id)
        content_tag(:snippet, current_webpage[:snippets].find { |snippet| snippet.name == id }, id: id)
      end

      def seo_title
        current_webpage[:seo_title]
      end

      def seo_description
        current_webpage[:seo_description]
      end

      def noindex
        current_webpage[:noindex]
      end

      def nofollow
        current_webpage[:nofollow]
      end

      def noodp
        current_webpage[:noodp]
      end

      def nosnippet
        current_webpage[:nosnippet]
      end

      def noarchive
        current_webpage[:noarchive]
      end

      def noimageindex
        current_webpage[:noimageindex]
      end
    end
  end
end
