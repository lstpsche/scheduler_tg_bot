# frozen_string_literal: true

module Decorators
  module Schedules
    class AllSchedules < Base
      # 'initialize' is in base

      def decoration_parts
        [@text]
      end
    end
  end
end
