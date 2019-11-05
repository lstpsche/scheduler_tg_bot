# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class MySchedules < Base
        # attrs from base -- :bot, :chat_id, :user

        # 'initialize' is in base
        # 'show' method is in base

        def show
          params = {
            markup_options: user.schedules
          }

          super(params)
        end

        def back
          show_main_menu
        end

        private

        # command here is schedule_id
        def callback(command)
          Constants.my_schedules_callback % {
            command: command
          }
        end

        def create_markup(markup_options)
          back_text = I18n.t('actions.features.schedules.my_schedules.back')

          super(markup_options) do
            # TODO: after removing all `return_to`, replace this 'back' with callback()
            create_button(back_text, 'back')
          end
        end

        def message_text
          I18n.t('actions.features.schedules.my_schedules.header')
        end

        # here option, which will be passed, is one of user's schedule
        def option_button(schedule)
          schedule.name
        end

        def option_name(schedule)
          schedule.id
        end

        # 'create_button' is in base
      end
    end
  end
end
