# frozen_string_literal: true

module Services
  module Schedules
    class ScheduleSettingSetupService < Services::Schedules::Base
      # attrs from base -- :bot, :chat_id, :user, :schedule

      # 'initialize' is in base

      def setup_option(setting_name)
        @setting_name = setting_name

        setup(setting_name)
      rescue StandardError
        show_not_setup
      end

      private

      def resource
        @schedule
      end

      def message_text
        I18n.t("actions.features.schedules.schedule_settings.options.#{@setting_name}.text")
      end
    end
  end
end
