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
        handle_schedule(command)
      end

      private

      def call_handler(action, schedule_id)
        method(HANDLE_METHODS[action]).call(schedule_id)
      end
    end
  end
end
