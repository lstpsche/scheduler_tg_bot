# frozen_string_literal: true

module Decorators
  module Schedules
    class ScheduleSettings < Base
      # 'initialize' is in base

      def decoration_parts
        schedule_settings_default_parts
      end

      private

      def header
        super(I18n.t('layouts.menus.schedule_settings.header'))
      end
    end
  end
end
