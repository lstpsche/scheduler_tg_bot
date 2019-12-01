# frozen_string_literal: true

module Decorators
  module Schedules
    class CreateSchedule < Base
      # 'initialize' is in base

      def decoration_parts
        default_decoration_parts_without_additional_info
      end

      private

      def header
        I18n.t('layouts.menus.create_schedule.header')
      end
    end
  end
end
