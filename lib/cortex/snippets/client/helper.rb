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
          build_robot_information
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

        def build_robot_information
          robot_information = []
          index_options = [:noindex, :nofollow, :noodp, :nosnippet, :noarchive, :noimageindex]

          index_options.each do |index_option|
            robot_information << index_option if valid_index_option?(index_option)
          end

          robot_information.join(", ")
        end

        def valid_index_option?(index_option)
          webpage[index_option]
        end
      end
    end
  end
end
