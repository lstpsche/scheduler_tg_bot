# frozen_string_literal: true

module Handlers
  module Callbacks
    class ScheduleSettings < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      HANDLE_METHODS = {
        'example_option': :show_schedule_setting,
        'back': :show_short_schedule
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        schedule_id, action = command.to_s.split('__')
        check_schedule_validity(schedule_id)

        call_handler(action, schedule_id) if handle_actions.include?(action)
      end

      private

      def call_handler(action, schedule_id)
        method(HANDLE_METHODS[action]).call(schedule_id)
      end

      def handle_actions
        HANDLE_METHODS.keys
      end
    end
  end
end
