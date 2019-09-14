# frozen_string_literal: true

module Actions
  module Features
    class MySchedules < Base
      # 'show' method is in base
      # 'back' method is in base
      private

      # command here is schedule_id
      def callback(command)
        Constants.my_schedules_callback % {
          command: command,
          return_to: nil
        }
      end

      # create_button is in base

      def create_markup
        super(user.schedules) do
          back_text = I18n.t('actions.features.my_schedules.back')
          create_button(back_text, 'back')
        end
      end

      def message_text
        I18n.t('actions.features.my_schedules.header')
      end

      # here option, which will be passed, is one of user's schedule
      def option_button(option)
        option.name
      end

      def option_name(option)
        option.id
      end
    end
  end
end
