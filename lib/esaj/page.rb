require 'nokogiri'
require 'open-uri'
require 'openssl'

module Esaj
  class Page
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def data
      document.css('a.linkProcesso')
    end

    def last_page?
      document.at('a:contains(">>")').nil?
    end

    private

    def document
      @document ||= Nokogiri::HTML(open(url, ssl_verify_mode: ::OpenSSL::SSL::VERIFY_NONE))
    end
  end
end
