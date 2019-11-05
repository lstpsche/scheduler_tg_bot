# frozen_string_literal: true

module Handlers
  module Callbacks
    class MySchedules < Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      # 'initialize' is in base

      def handle(command)
        case command
        # when 'add_schedule'
        #   show_add_schedule
        when 'back'
          call_back_my_schedules
        else
          schedule_id = command.to_i
          show_schedule(schedule_id) if schedule_id > 0
        end
      end
    end
  end
end
