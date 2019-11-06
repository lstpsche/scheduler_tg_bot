# frozen_string_literal: true

module Constants
  module Regexes
    def command_regex
      /^\/(\w+)$/
    end

    def context_command_regex
      /^(\w+)-(\w+)?$/
    end
  end
end
