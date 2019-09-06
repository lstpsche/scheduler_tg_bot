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
        text = "*#{schedule.name}*\n#{schedule_additional_info}\n"

        Constants.weekdays.each do |weekday|
          text = text + "\n" + weekday_decorated_text(weekday)
        end

        text
      end

      private

      def weekday_decorated_text(weekday)
        header_weekday = "*#{weekday.capitalize}*:\n"
        schedule_events = events.select { |ev| ev.weekday == weekday }.map do |event|
          Constants.event_in_schedule_decoration % {
            time: event.time,
            info: event.info,
            additional_info: event.additional_info
          } + "\n"
        end.inject(&:+)

        schedule_events ? header_weekday + schedule_events : ''
      end
    end
  end
end
