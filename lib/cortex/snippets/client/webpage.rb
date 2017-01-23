module Cortex
  module Snippet
    module Client
      class Webpage
        attr_reader :webpage

        def initialize(request, cortex_client)
          sanitized_url = sanitized_webpage_url(request.original_url)
          @webpage = Rails.cache.fetch("webpages/#{cortex_client.access_token.client.id}/#{sanitized_url}", race_condition_ttl: 10) do
            cortex_client.webpages.get_feed(sanitized_url).contents
          end
        end

        def seo_title
          webpage[:seo_title]
        end

        def seo_description
          webpage[:seo_description]
        end

        def seo_keywords
          webpage[:seo_keyword_list]
        end

        def seo_robots
          robot_information = []
          index_options = [:noindex, :nofollow, :noodp, :nosnippet, :noarchive, :noimageindex]

          index_options.each do |index_option|
            robot_information << index_option if webpage[index_option]
          end

          robot_information
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

        def dynamic_yield
          {
            sku: webpage[:dynamic_yield_sku],
            category: webpage[:dynamic_yield_category]
          }
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
end
