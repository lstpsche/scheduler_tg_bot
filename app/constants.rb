# frozen_string_literal: true

class Constants
  class << self
    def command_regex
      /^\/(\w+)$/
    end

    def context_command_regex
      /^(\w+)-(\w+)(-(\w+))?$/
    end

    def event_in_schedule_decoration
      "*%{time}*: %{info} _(%{additional_info})_"
    end

    def in_schedule_options
      scope = 'actions.features.schedule.options'

      IN_SCHEDULE_OPTIONS.map do |option|
        I18n.t(option, scope: scope)
      end
    end

    # TODO: rewrite all those like "schedule_options"
    def menu_options
      [
        'new schedule',
        'my schedules',
        'preferences'
      ]
    end

    def my_schedules_callback
      "my_schedules-%{command}%{return_to}"
    end

    def options
      scope = 'actions.users.options'

      PREFERENCES_OPTIONS.inject([]) do |result, option_name|
        # returns hash: { name: '.....', text: '....' }
        result << I18n.t(option_name, scope: scope)
      end
    end

    def schedule_callback
      "schedule-%{schedule_id}__%{option}%{return_to}"
    end

    def schedule_options
      scope = 'actions.features.schedule.options'

      SCHEDULE_OPTIONS.map do |option|
        I18n.t(option, scope: scope)
      end
    end

    # using for inner coding. doesn't needed to translate
    def weekdays
      [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'saturday',
        'sunday'
      ]
    end

    private

    IN_SCHEDULE_OPTIONS = [
      :hide_schedule,
      :pin,
      :back
    ]

    PREFERENCES_OPTIONS = [
      :example_option_1,
      :back
    ]

    SCHEDULE_OPTIONS = [
      :show_schedule,
      :back
    ]
  end
end
