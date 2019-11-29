# frozen_string_literal: true

module Decorators
  class MainMenu
    def initialize(context, text)
      @text = text
      @context = context
    end

    def decoration_parts
      [@text]
    end
  end
end
