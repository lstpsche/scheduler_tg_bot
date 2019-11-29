# frozen_string_literal: true

module Decorators
  module Schedules
    class ScheduleSetting
      def initialize(context, text)
        @text = text
        @context = context
        @schedule = context[:resource]
      end

      def decoration_parts
        [header, '', @text]
      end

      private

      def header
        I18n.t('layouts.menus.schedule_setting.header') % {
          schedule_name: @schedule.name,
          schedule_id: @schedule.id
        }
      end
    end
  end
end
