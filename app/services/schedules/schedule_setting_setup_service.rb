# frozen_string_literal: true

module Services
  module Schedules
    class ScheduleSettingSetupService < Services::Schedules::Base
      # attrs from base -- :bot, :chat_id, :user, :schedule

      # 'initialize' is in base

      def setup_option(setting_name: option_name)
        @setting_name = setting_name
        send_setting_message(@setting_name)
        receive_response

        @schedule.send("#{@setting_name}=", @response)

        save_action_schedule { show_successfully_setup }
      rescue NoMethodError
        show_not_setup
      end

      private

      def message_text
        I18n.t("actions.features.schedules.schedule_settings.options.#{@setting_name}.text")
      end

      def save_action_schedule
        if schedule.save
          yield
        else
          show_something_wrong
          # TBD: maybe parse errors and show them to user
          # (rather no)
        end
      end
    end
  end
end
