require 'nokogiri'
require 'open-uri'
require 'openssl'

module Esaj
  class ParserAdapter
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def document
      @document ||= Nokogiri::HTML(open(url, ssl_verify_mode: ::OpenSSL::SSL::VERIFY_NONE))
    end
  end
end
