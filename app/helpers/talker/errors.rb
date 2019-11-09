# frozen_string_literal: true

module Helpers
  module Talker
    module Errors
      private

      def show_bad_input
        talker.show_bad_input
      end

      def show_no_command
        talker.show_no_command
      end

      def show_not_registered
        talker.show_not_registered
      end

      def show_not_understand
        talker.show_not_understand
      end

      def show_something_wrong
        talker.show_something_wrong
      end
    end
  end
end
