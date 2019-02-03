require_relative 'parser_adapter'

module Esaj
  class Metadata
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def total_pages
      (total_records.to_f/records_per_page).round
    end

    def error?
      !error_message.empty?
    end

    def error_message
      formatted_error_message
    end

    private

    def records_per_page
      formatted_pagination_result[3].to_i
    end

    def total_records
      formatted_pagination_result[5].to_i
    end

    def formatted_pagination_result
      pagination_element.text.split.uniq
    end

    def formatted_error_message
      error_message_element.text.strip
    end

    def error_message_element
      @error_message_element ||= document.css('td#mensagemRetorno')
    end

    def pagination_element
      @pagination_element ||= document.css('span.resultadoPaginacao')
    end

    def document
      @document ||= ParserAdapter.new(url).document
    end
  end
end
