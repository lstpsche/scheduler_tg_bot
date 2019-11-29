# frozen_string_literal: true

module Decorators
  module Schedules
    class AllSchedules
      def initialize(context, text)
        @text = text
        @context = context
      end
      #################### TODO: MAYBE CREATE BASE CLASS AND MOVE DUPLICATING METHODS THERE
      def decoration_parts
        [path, '', @text]
      end

      private

      def path
        # TODO: to be done
        # context[:path] = ['menu', 'schedules', 'schedule #15', 'schedule settings', ....]
      end
    end
  end
end
