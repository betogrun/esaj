require_relative 'parser_adapter'
require_relative 'result_item'

module Esaj
  class QueryPage
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def result_set
      elements.each_with_object([]) do |element, result_set|
        result_set << result_item_for(element)
      end
    end

    private

    def elements
      document.css('div[id^="divProcesso"]')
    end

    def result_item_for(element)
      ResultItem.new(element).attributes
    end

    def document
      @document ||= ParserAdapter.new(url).document
    end
  end
end
