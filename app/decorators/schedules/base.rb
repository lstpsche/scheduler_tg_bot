# frozen_string_literal: true

module Decorators
  module Schedules
    class Base < Decorators::Base
      def initialize(context, text)
        super
        @schedule = context[:resource]
      end

      def decoration_parts
        [header, additional_info, '', @text]
      end

      def default_decoration_parts_without_additional_info
        [header, '', @text]
      end

      private

      def header(locale = I18n.t('layouts.menus.schedule.header'))
        locale % {
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
