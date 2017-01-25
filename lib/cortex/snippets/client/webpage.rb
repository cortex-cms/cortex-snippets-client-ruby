module Cortex
  module Snippets
    module Client
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
      end
    end
  end
end
