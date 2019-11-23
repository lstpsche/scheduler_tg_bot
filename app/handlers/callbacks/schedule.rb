# frozen_string_literal: true

module Handlers
  module Callbacks
    class Schedule < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      HANDLE_METHODS = {
        with_args: {
          'expand': :show_expanded_schedule,
          'hide': :show_short_schedule,
          'settings': :show_schedule_settings
        },
        'pin': :pin_schedule,
        'back': :call_back_schedule
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        handle_schedule(command)
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

      def handle_actions
        HANDLE_METHODS.keys + HANDLE_METHODS[:with_args].keys
      end
    end
  end
end
