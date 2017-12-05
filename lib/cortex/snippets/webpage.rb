module Cortex
  module Snippets
    class Webpage
      def initialize(cortex_client, url, path)
        @webpage = cortex_client.webpages.get_feed(url)
        @contents = @webpage.contents
        @page_cache_key = @webpage.status == 200 ? "root#{path}@#{@contents.updated_at}" : "root#{path}"
      end

      def page_cache_key
        @page_cache_key
      end

      def seo_title
        @contents[:seo_title]
      end

      def seo_description
        @contents[:seo_description]
      end

      def seo_keywords
        @contents[:seo_keyword_list]
      end

      def seo_robots
        robot_information = []
        index_options = [:noindex, :nofollow, :noodp, :nosnippet, :noarchive, :noimageindex]

        index_options.each do |index_option|
          robot_information << index_option if @contents[index_option]
        end

        robot_information
      end

      def noindex
        @contents[:noindex]
      end

      def nofollow
        @contents[:nofollow]
      end

      def noodp
        @contents[:noodp]
      end

      def nosnippet
        @contents[:nosnippet]
      end

      def noarchive
        @contents[:noarchive]
      end

      def noimageindex
        @contents[:noimageindex]
      end

      def dynamic_yield
        {
          sku: @contents[:dynamic_yield_sku],
          category: @contents[:dynamic_yield_category]
        }
      end

      def tables_widget_data
        JSON.parse(@contents[:tables_widget_json] || 'null', quirks_mode: true)
      end

      def tables_widget_data_for(section_name)
        tables_widget_data&.[](section_name) || []
      end

      def carousels_widget_data
        JSON.parse(@contents[:carousels_widget_json] || 'null', quirks_mode: true)
      end

      def carousels_widget_data_for(section_name)
        carousels_widget_data&.[](section_name)
      end

      def galleries_widget_data
        JSON.parse(@contents[:galleries_widget_json] || 'null', quirks_mode: true)
      end

      def galleries_widget_data_for(section_name)
        galleries_widget_data&.[](section_name)
      end

      def accordion_group_widget_data
        JSON.parse(@contents[:accordion_group_widget_json] || 'null', quirks_mode: true)
      end

      def accordion_group_widget_data_for(section_name)
        accordion_group_widget_data&.[](section_name) || []
      end

      def charts_widget_data
        JSON.parse(@contents[:charts_widget_json] || 'null', quirks_mode: true)
      end

      def buy_box_widget_data
        JSON.parse(@contents[:buy_box_widget_json] || 'null', quirks_mode: true)
      end

      def charts_widget_data_for(section_name)
        charts_widget_data&.[](section_name) || {}
      end

      def snippets
        @contents[:snippets]
      end
    end
  end
end
