# frozen_string_literal: true

module Handlers
  module Callbacks
    class AddSchedule < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule

      HANDLE_METHODS = {
        'create': :create_schedule_action,
        'back': :show_all_schedules
        # 'external': :add_external_schedule
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        if handler_exists_for?(command)
          call_handler(command)
        else
          add_schedule(command)
        end
      end

      private

      def handler_exists_for?(command)
        HANDLE_METHODS.keys.include?(command)
      end

      def call_handler(command)
        method(HANDLE_METHODS[command]).call
      end

      # This is legacy-code for now
      # don't remove it, because maybe I will use it at 'add_external' implementation

      def add_schedule(schedule_id)
        check_schedule_validity(schedule_id)
        add_schedule_to_user
        show_all_schedules
      end

      def add_schedule_to_user
        Services::Schedules::ScheduleUserInteraction.new(bot: bot, user: user, schedule: schedule).perform
      end
    end
  end
end
