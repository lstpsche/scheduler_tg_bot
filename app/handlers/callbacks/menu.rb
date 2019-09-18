# frozen_string_literal: true

module Handlers
  module Callbacks
    class Menu < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def show_new_schedule_menu
        return false if not_registered_user(id: chat_id)

        # TODO: launch NewScheduleCreator here
      end

      def show_my_schedules_menu
        return false if not_registered_user(id: chat_id)

        show_my_schedules
      end

      def show_preferences_menu
        return false if not_registered_user(id: chat_id)

        show_preferences
      end

      def handle(command)
        case command
        when 'new_schedule'
          show_new_schedule_menu
        when 'my_schedules'
          show_my_schedules_menu
        when 'preferences'
          show_preferences_menu
        end
      end

      private

      def not_registered_user(id:)
        if user_not_registered?(id: id)
          show_not_registered(chat_id: id)
          return true
        end

        false
      end
    end
  end
end
