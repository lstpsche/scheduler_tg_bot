# frozen_string_literal: true

module Services
  module Schedules
    class Base < Services::Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule

      def initialize(bot:, user:, schedule:)
        super(bot: bot, user: user)
        @schedule = schedule
      end

      # 'send_setting_message' is in base
      # 'message_text' is in base
    end
  end
end
