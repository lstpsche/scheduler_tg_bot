# frozen_string_literal: true

module Decorators
  module Schedules
    class ShortSchedule
      def initialize(context, text)
        @text = text
        @context = context
        @schedule = context[:resource]
      end

      def decoration_parts
        [path, header, additional_info, @text]
      end

      private

      def path
        # TODO: to be done somewhen
      end

      def header
        I18n.t('layouts.menus.schedule.header') % {
          schedule_name: @schedule.name,
          schedule_id: @schedule.id
        }
      end

      def additional_info
        I18n.t('layouts.menus.schedule.additional_info') % {
          info: @schedule.additional_info
        }
      end
    end
  end
end
