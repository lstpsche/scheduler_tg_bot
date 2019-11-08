# frozen_string_literal: true

module Handlers
  module Callbacks
    class AllSchedules < Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      HANDLE_METHODS = {
        'add_schedule': :show_add_schedule,
        'back': :call_back_all_schedules
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        if handler_exists_for?(command)
          call_handler(command)
        else
          schedule_id = command.to_i
          show_schedule(schedule_id) if schedule_id.positive?
        end
      end

      private

      def handler_exists_for?(command)
        HANDLE_METHODS.keys.include?(command)
      end

      def call_handler(command)
        method(HANDLE_METHODS[command]).call
      end
    end
  end
end
