# frozen_string_literal: true

module Decorators
  class Base
    def initialize(context, text = nil)
      @text = text
      @context = context
    end
  end
end
