# frozen_string_literal: true

module Handlers
  module Callbacks
    class Schedule < Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      # 'initialize' is in base

      def handle(command)
        schedule_id, option_name = command.to_s.split('_', 2)

        case option_name
        when 'expand'
          expand_schedule(schedule_id)
        when 'hide'
          hide_schedule(schedule_id)
        when 'pin'
          pin_schedule
        when 'back'
          call_back_schedule
        end
      end
    end
  end
end
