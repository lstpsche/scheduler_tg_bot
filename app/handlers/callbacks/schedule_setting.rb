# frozen_string_literal: true

module Handlers
  module Callbacks
    class ScheduleSetting < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      HANDLE_METHODS = {
        'back': :show_schedule_settings
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        @schedule_id, option_action = command.to_s.split('__', 2)
        action = option_action.split('__', 2).last

        super(action) do
          call_schedule_settings_router_with(::Schedule.find_by(id: @schedule_id), option_action)
          # setup_schedule_setting(::Schedule.find_by(id: @schedule_id), option_name)
        end
      end

      private

      def call_handler(action)
        show_schedule_settings(@schedule_id)
      end
    end
  end
end
