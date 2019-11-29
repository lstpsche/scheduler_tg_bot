# frozen_string_literal: true

module Decorators
  module Schedules
    class ScheduleSetting < Base
      # 'initialize' is in base

      def decoration_parts
        [header, '', @text]
      end

      private

      def header
        super(I18n.t('layouts.menus.schedule_setting.header'))
      end
    end
  end
end
