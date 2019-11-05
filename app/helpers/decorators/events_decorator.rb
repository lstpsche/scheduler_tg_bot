# frozen_string_literal: true

module Helpers
  module Decorators
    class EventsDecorator
      attr_reader :events, :schedule

      def initialize(schedule)
        @schedule = schedule
        @events = schedule.events
      end

      def decorate_for_show_schedule
        schedule_additional_info = schedule.additional_info
        schedule_additional_info += "\n" unless schedule_additional_info.blank?
        text = I18n.t('messages_layouts.schedule_view.title',
                 schedule_name: schedule.name,
                 schedule_id: schedule.id,
                 schedule_additional_info: schedule_additional_info
               )

        Constants.weekdays.each do |weekday|
          text += weekday_decorated_text(weekday)
        end

        text
      end

      private

      def weekday_decorated_text(weekday)
        header_weekday = I18n.t('message_layouts.schedule_view.events.weekday', weekday: weekday.capitalize)
        schedule_events = events.select { |ev| ev.weekday == weekday }.map do |event|
          Constants.event_in_schedule_decoration % {
            time: event.time,
            info: event.info,
            additional_info: event.additional_info
          } + "\n"
        end.inject(&:+)

        schedule_events ? header_weekday + schedule_events + "\n" : ''
      end
    end
  end
end
