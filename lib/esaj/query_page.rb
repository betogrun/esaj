require_relative 'parser_adapter'

module Esaj
  class QueryPage
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def result_set
      result_elements.each_with_object([]) do |result_element, result_set|
        result_set << result_item_for(result_element)
      end
    end

    private

    def result_item_for(result_element)
      {
        lawsuit_code: result_element.text,
        lawsuit_details_resource: result_element[:href]
      }
    end

    def result_elements
      document.css('a.linkProcesso')
    end

    def document
      @docuemnt ||= ParserAdapter.new(url).document
    end
  end
end
