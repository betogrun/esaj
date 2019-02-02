module Esaj
  module Forum
    VALUES = {
      all: -1,
      foro_central_civel: 100
    }

    def self.code_for(option)
      VALUES[option]
    end
  end
end
