module Esaj
  class Lawsuit
    attr_reader :raw_attributes

    def initialize(raw_attributes)
      @raw_attributes = raw_attributes
    end

    def attributes
      {
        code: code,
        details_resource: details_resource
      }
    end

    private

    def code
      raw_attributes[:lawsuit_code].strip
    end

    def details_resource
      "https://esaj.tjsp.jus.br#{raw_attributes[:lawsuit_details_resource]}"
    end
  end
end
