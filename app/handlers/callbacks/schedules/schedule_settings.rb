# frozen_string_literal: true

module Handlers
  module Callbacks
    module Schedules
      class ScheduleSettings < Handlers::Callbacks::Base
        # attrs from base -- :bot, :chat_id, :user, :talker

        HANDLE_METHODS = {
          'back': :show_short_schedule
        }.with_indifferent_access

        # 'initialize' is in base

        def handle(command)
          schedule_id, option_action = command.split('__', 2)
          @schedule = ::Schedule.find_by(id: schedule_id)
          action = option_action.split('__').first

          super(action) do
            call_schedule_settings_router_with(@schedule, option_action)
          end
        end

        private

        def call_handler(command)
          method(HANDLE_METHODS[command]).call(@schedule.id)
        end
      end
    end
  end
end
