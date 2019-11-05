# frozen_string_literal: true

module Services
  module Schedules
    class ScheduleUserInteraction < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule

      def initialize(bot:, user:, schedule: nil)
        super(bot: bot, user: user)
        @schedule = schedule
      end

      def perform
        user.schedules << schedule
        user.save
      end

      # this, probably, should be at web ver.
      def edit_schedule
        user.schedules.where(id: schedule.id).first = schedule.clone.update(custom: true, customed_by: user.id)
        user.save
      end
    end
  end
end
