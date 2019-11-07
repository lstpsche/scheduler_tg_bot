# frozen_string_literal: true

module Handlers
  module Callbacks
    class AddSchedule < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule

      # 'initialize' is in base

      def handle(command)
        case command
        when 'create'
          create_schedule_action
        when 'back'
          show_all_schedules
        else
          add_schedule(command)
        end
      end

      private

      def add_schedule(schedule_id)
        @schedule = ::Schedule.find_by(id: schedule_id)

        check_schedule_validity
        add_schedule_to_user
        show_all_schedules
      end

      def add_schedule_to_user
        Services::Schedules::ScheduleUserInteraction.new(bot: bot, user: user, schedule: schedule).perform
      end

      def create_schedule_action
        ::Actions::Features::Schedules::CreateSchedule.new(bot: bot, user: user).show
      end

      def check_schedule_validity
        raise 'Invalid schedule_id' unless schedule.present?
      end
    end
  end
end
