# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class ScheduleSetting < Actions::Features::Schedules::Base
        # attrs from parent -- :bot, :chat_id, :user, :params
        attr_reader :schedule

        # 'initialize' is in base

        def show(schedule:, setting_name:)
          @schedule = schedule

          @params = Params.new(
            before: { setting: setting_name },
            markup_options: Constant.schedule_setting_options
          )

          super()
        end

        private

        def before_show
          params.update(resource: given_setting_params)
        end

        def given_setting_params
          Constant.schedule_settings_options.select { |sett| sett[:name] == params.before[:setting] }
                  .first.with_indifferent_access
        end

        def message_text
          resource = params.resource
          I18n.t('actions.features.schedules.schedule_setting_text') % {
            setting_name: resource[:button_text],
            setting_value: setting_value(resource, @schedule.try(resource[:name])) || I18n.t('shared.settings.not_set')
          }
        end

        def setting_value(resource, value)
          return value unless value.in?([true, false])

          resource[:value][value.to_s]
        end

        def create_button_for_kb(option)
          super do |button|
            button.update(callback: schedule_setting_callback(option))
          end
        end

        def schedule_setting_callback(args)
          Constant.schedule_setting_callback % {
            schedule_id: @schedule.id,
            option_name: params.resource[:name],
            action: args[:name]
          }
        end
      end
    end
  end
end
