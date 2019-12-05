# frozen_string_literal: true

module Handlers
  module Callbacks
    module Schedules
      class AllSchedules < Handlers::Callbacks::Base
        # attrs from base -- :bot, :chat_id, :user, :talker

        HANDLE_METHODS = {
          'add_schedule': :show_add_schedule,
          'back': :call_back_all_schedules
        }.with_indifferent_access

        # 'initialize' is in base

        def handle(command)
          super do
            check_schedule_validity(command)
            show_short_schedule(@schedule.id)
          end
        end
      end
    end
  end
end
