# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class AllSchedules < Actions::Features::Schedules::Base
        # attrs from base -- :bot, :chat_id, :user, :params

        # 'initialize' is in base

        def show
          @params = Params.new(
            markup_options: user.schedules
          )

          super
        end

        def back
          show_main_menu
        end

        private

        def callback
          Constant.all_schedules_callback
        end

        def create_markup
          super do
            [
              add_button,
              back_button
            ]
          end
        end

        def add_button
          add_schedule = I18n.t('actions.features.schedules.all_schedules.add_schedule')
          create_button(add_schedule).inline
        end

        def back_button
          back_btn = I18n.t('actions.features.schedules.all_schedules.back')
          create_button(back_btn).inline
        end

        def message_text
          I18n.t('actions.features.schedules.all_schedules.header')
        end

        def create_button_for_kb(schedule)
          super({}) do |button|
            button.update(schedule_options(schedule))
          end
        end

        def schedule_options(schedule)
          { text: schedule.name, name: schedule.id }
        end
      end
    end
  end
end
