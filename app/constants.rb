# frozen_string_literal: true

class Constants
  class << self
    def command_regex
      /^\/(\w+)$/
    end

    def context_command_regex
      /^(\w+)-(\w+)(-(\w+))?$/
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
      "my_schedules-%{id}%{return_to}"
    end

    def options
      [
        'example_option_1'
      ]
    end

    def schedule_callback
      "schedule-%{option}%{return_to}"
    end

    def schedule_options
      scope = 'actions.features.schedule.options'
      [
        I18n.t(:show_schedule, scope: scope),
        I18n.t(:back, scope: scope)
      ]
    end
  end
end
