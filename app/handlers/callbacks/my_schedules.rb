# frozen_string_literal: true

module Handlers
  module Callbacks
    class MySchedules < Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      # 'initialize' is in base

      def handle(command)
        back && return if command == 'back'

        schedule_id = command.to_i
        show_schedule(schedule_id)
      end

      def back
        call_back_my_schedules
      end
    end
  end
end
