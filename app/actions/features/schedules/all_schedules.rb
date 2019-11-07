# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class AllSchedules < Base
        # attrs from base -- :bot, :chat_id, :user

        # 'initialize' is in base

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
          Constant.all_schedules_callback % {
            command: command
          }
        end

        def create_markup(markup_options)
          super(markup_options) do
            [
              add_button,
              back_button
            ]
          end
        end

        def add_button
          add_text = I18n.t('actions.features.schedules.all_schedules.add_schedule.button_text')
          add_callback = I18n.t('actions.features.schedules.all_schedules.add_schedule.name')

          create_button(add_text, add_callback)
        end

        def back_button
          back_text = I18n.t('actions.features.schedules.all_schedules.back.button_text')
          back_callback = I18n.t('actions.features.schedules.all_schedules.back.name')

          create_button(back_text, back_callback)
        end

        def message_text
          I18n.t('actions.features.schedules.all_schedules.header')
        end

        # here option, which will be passed, is one of user's schedule
        def option_button_text(schedule)
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
