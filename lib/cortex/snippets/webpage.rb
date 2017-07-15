module Cortex
  module Snippets
    class Webpage
      def initialize(cortex_client, url)
        @webpage = cortex_client.webpages.get_feed(url).contents
      end

      def seo_title
        @webpage[:seo_title]
      end

      def seo_description
        @webpage[:seo_description]
      end

      def seo_keywords
        @webpage[:seo_keyword_list]
      end

      def seo_robots
        robot_information = []
        index_options = [:noindex, :nofollow, :noodp, :nosnippet, :noarchive, :noimageindex]

        index_options.each do |index_option|
          robot_information << index_option if @webpage[index_option]
        end

        robot_information
      end

      def noindex
        @webpage[:noindex]
      end

      def nofollow
        @webpage[:nofollow]
      end

      def noodp
        @webpage[:noodp]
      end

      def nosnippet
        @webpage[:nosnippet]
      end

      def noarchive
        @webpage[:noarchive]
      end

      def noimageindex
        @webpage[:noimageindex]
      end

      def dynamic_yield
        {
          sku: @webpage[:dynamic_yield_sku],
          category: @webpage[:dynamic_yield_category]
        }
      end

      def tables_widget_data
        JSON.parse(@webpage[:tables_widget_json] || 'null', quirks_mode: true)
      end

      def tables_widget_data_for(section_name)
        tables_widget_data&.[](section_name) || []
      end

      def accordion_group_widget_data
        JSON.parse(@webpage[:accordion_group_widget_json] || 'null', quirks_mode: true)
      end

      def accordion_group_widget_data_for(section_name)
        accordion_group_widget_data&.[](section_name) || []
      end

      def charts_widget_data
        JSON.parse(@webpage[:charts_widget_json] || 'null', quirks_mode: true)
      end

      def buy_box_widget_data
        JSON.parse(@webpage[:buy_box_widget_json] || 'null', quirks_mode: true)
      end

      def charts_widget_data_for(section_name)
        charts_widget_data&.[](section_name) || {}
      end

      def snippets
        @webpage[:snippets]
      end
    end
  end
end
