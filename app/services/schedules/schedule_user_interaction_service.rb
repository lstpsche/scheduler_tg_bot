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
    end
  end
end
