# frozen_string_literal: true

module Decorators
  module Schedules
    class AllSchedules
      def initialize(context, text)
        @text = text
        @context = context
      end

      def decoration_parts
        [@text]
      end
    end
  end
end
