# frozen_string_literal: true

module Services
  module Schedules
    class ScheduleUserInteraction < Services::Base
      # attrs from base -- :bot, :chat_id, :user, :schedule

      # 'initialize' is in base

      def add_schedule_to_user
        user.schedules << schedule
        user.save
      end
    end
  end
end
