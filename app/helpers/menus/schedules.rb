# frozen_string_literal: true

module Helpers
  module Menus
    module Schedules
      private

      ################# All Schedules #################################

      def show_add_schedule(no_back: false, message_text: nil)
        ::Actions::Features::Schedules::AddSchedule
          .new(bot: bot, user: user, no_back: no_back, message_text: message_text).show
      end

      def call_back_all_schedules
        ::Actions::Features::Schedules::AllSchedules.new(bot: bot, user: user).back
      end

      def create_schedule_action
        ::Actions::Features::Schedules::CreateSchedule.new(bot: bot, user: user).show
      end

      ################# Schedule #####################################

      def show_short_schedule(schedule_id)
        ::Actions::Features::Schedules::ShortSchedule.new(bot: bot, user: user).show(schedule_id: schedule_id)
      end

      def show_expanded_schedule(schedule_id)
        ::Actions::Features::Schedules::ExpandedSchedule.new(bot: bot, user: user).show(schedule_id: schedule_id)
      end

      def pin_schedule
        ::Actions::Features::Schedules::Schedule.new(bot: bot, user: user).pin
      end

      def call_back_schedule
        ::Actions::Features::Schedules::Schedule.new(bot: bot, user: user).back
      end
    end
  end
end
