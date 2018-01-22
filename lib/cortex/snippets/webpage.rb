module Cortex
  module Snippets
    class Webpage
      attr_reader :response, :url, :contents, :status

      def initialize(cortex_client, url)
        @url = url
        @response = cortex_client.webpages.get_feed(url)
        @status = @response.status
        @contents = @response.contents
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

      def card_group_widget_data
        JSON.parse(@contents[:card_group_widget_json] || 'null', quirks_mode: true)
      end

      def card_group_widget_data_for(section_name)
        card_group_widget_data&.[](section_name)
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

      def product_data
        @product_data ||= JSON.parse(@contents[:product_data_json] || 'null', quirks_mode: true)
      end

      def form_configs
        @form_configs ||= JSON.parse(@contents[:form_configs_json] || 'null', quirks_mode: true)
      end

      def snippets
        @contents[:snippets]
      end
    end
  end
end
