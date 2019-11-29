# frozen_string_literal: true

module Decorators
  module Schedules
    class ExpandedSchedule
      def initialize(context, text)
        @text = text
        @context = context
        @schedule = context[:resource]
      end
      #################### TODO: MAYBE CREATE BASE CLASS AND MOVE DUPLICATING METHODS THERE
      def decoration_parts
        [path, title, additional_info, '', @text]
      end

      private

      def path
        # TODO: to be done
        # context[:path] = ['menu', 'schedules', 'schedule #15', 'schedule settings', ....]
      end

      def title
        I18n.t('layouts.menus.schedule.title') % {
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
