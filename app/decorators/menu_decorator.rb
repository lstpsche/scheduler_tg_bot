# frozen_string_literal: true

module Decorators
  class MenuDecorator
    CONTEXT_TITLE = {
      'short_schedule': Schedules::ShortSchedule,
      'expanded_schedule': Schedules::ExpandedSchedule,
      'all_schedules': Schedules::AllSchedules,
      'schedule_setting': Schedules::ScheduleSetting,
      'schedule_settings': Schedules::ScheduleSettings
    }.with_indifferent_access

    def initialize(text, context)
      @text = text
      @context = context
    end

    def self.decorate(context, text = '')
      new(text, context).full_view
    end

    def full_view
      context_class.decoration_parts.join("\n")
    end

    private

    def context_class
      @context_class ||= CONTEXT_TITLE[@context[:menu]].new(@context, @text)
    end
  end
end
