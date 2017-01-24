require 'cortex/snippets/client/webpage'

module Cortex
  module Snippet
    module Client
      module Helper
        def snippet(cortex_client, options = {}, &block)
          snippets = current_webpage(cortex_client)[:snippets] || []
          snippet = snippets.find { |snippet| snippet[:document][:name] == options[:id] }

          if snippet.nil? || snippet[:document][:body].nil? || snippet[:document][:body].empty?
            content_tag(:snippet, capture(&block), options)
          else
            content_tag(:snippet, snippet[:document][:body].html_safe, options)
          end
        end

        def current_webpage(cortex_client)
          if defined?(Rails)
            Cortex::Snippets::Client::Webpage.new(request, cortex_client)
          else
            raise 'Your Web framework is not supported. Supported frameworks: Rails'
          end
        end
      end
    end
  end
end
