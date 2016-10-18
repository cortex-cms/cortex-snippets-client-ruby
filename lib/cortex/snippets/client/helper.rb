module Cortex
  module Snippets
    module Client
      module Helper
        def snippet(options = {}, &block)
          snippets = webpage[:snippets] || []
          snippet = snippets.find { |snippet| snippet[:document][:name] == options[:id] }

          if snippet.nil? || snippet[:document][:body].nil? || snippet[:document][:body].empty?
            content_tag(:snippet, capture(&block), options)
          else
            content_tag(:snippet, snippet[:document][:body].html_safe, options)
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
          webpage[:seo_robots]
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
          Cortex::Snippets::Client::current_webpage(request)
        end
      end
    end
  end
end
