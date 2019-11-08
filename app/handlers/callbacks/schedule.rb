# frozen_string_literal: true

module Handlers
  module Callbacks
    class Schedule < Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      HANDLE_METHODS = {
        with_args: {
          'expand': :expand_schedule,
          'hide': :hide_schedule
        },
        'pin': :pin_schedule,
        'back': :call_back_schedule
      }.freeze

      # 'initialize' is in base

      def handle(command)
        schedule_id, action = command.to_s.split('__')

        call_handler(action, schedule_id) if handlers_keys.include?(action)
      end

      private

      def call_handler(action, schedule_id)
        handler = HANDLE_METHODS[:with_args][action].presence

        if handler
          method(handler).call(schedule_id)
        else
          method(HANDLE_METHODS[action]).call
        end
      end

      def handlers_keys
        HANDLE_METHODS.keys + HANDLE_METHODS[:with_args].keys
      end
    end
  end
end
