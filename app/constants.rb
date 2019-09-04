# frozen_string_literal: true

class Constants
  class << self
    def command_regex
      /^\/(\w+)$/
    end

    def context_command_regex
      /^(\w+)-(\w+)(-(\w+))?$/
    end

    def options
      [
        'example_option_1'
      ]
    end

    def menu_options
      [
        'schedule',
        'my schedules',
        'preferences'
      ]
    end

    def my_schedules_callback
      "my_schedules-%{id}%{return_to}"
    end

    def schedule_callback
      "schedule-%{option}%{return_to}"
    end
  end
end
