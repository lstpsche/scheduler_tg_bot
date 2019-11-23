# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class ScheduleSettings < Actions::Features::Schedules::Base
        # attrs from parent -- :bot, :chat_id, :user, :params

        # 'initialize' is in base

        def show(schedule_id:)
          find_schedule_by(id: schedule_id)

          @params = Params.new(
            markup_options: Constant.schedule_settings_options
          )

          super()
        end

        private

        def message_text
          I18n.t('actions.features.schedules.schedule_settings.header')
        end

        def schedule_settings_callback(args)
          Constant.schedule_settings_callback % {
            schedule_id: @schedule.id,
            action: args[:name]
          }
        end

        def create_button_for_kb(option)
          super do |button|
            button.update(callback: schedule_settings_callback(option))
          end
        end
      end
    end
  end
end
