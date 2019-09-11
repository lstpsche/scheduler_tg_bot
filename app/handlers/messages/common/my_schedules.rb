# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      class MySchedules < Base
        attr_reader :bot, :chat_id, :user

        def initialize(bot:, chat_id:, user:)
          @bot = bot
          @chat_id = chat_id
          @user = user
        end

        def method_missing(method_name, *args, &block)
          schedule_id = method_name.to_s.to_i

          Actions::Features::Schedule.new(bot: bot, chat_id: chat_id).show(schedule_id: schedule_id)
        end
      end
    end
  end
end
