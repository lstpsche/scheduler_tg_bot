# frozen_string_literal: true

class Constants
  class << self
    # REGEXES
    def command_regex
      /^\/(\w+)$/
    end

    def context_command_regex
      /^(\w+)-(\w+)(-(\w+))?$/
    end

    def event_in_schedule_decoration
      "*%{time}*: %{info} _(%{additional_info})_"
    end

    # OPTIONS

    def in_schedule_options
      scope = 'actions.features.schedule.options'

      options_translations_for(IN_SCHEDULE_OPTIONS, scope)
    end

    def option_options
      scope = 'actions.users.option'

      options_translations_for(OPTION_OPTIONS, scope)
    end

    def preferences_options
      scope = 'actions.users.options'

      options_translations_for(PREFERENCES_OPTIONS, scope)
    end

    def schedule_options
      scope = 'actions.features.schedule.options'

      options_translations_for(SCHEDULE_OPTIONS, scope)
    end

    # TODO: rewrite all those like "schedule_options"
    def menu_options
      scope = 'actions.features.menu'

      options_translations_for(MENU_OPTIONS, scope)
    end

    # CALLBACKS

    def main_menu_callback
      "menu-%{command}%{return_to}"
    end

    def my_schedules_callback
      "my_schedules-%{command}%{return_to}"
    end

    def option_callback
      "options-%{command}%{return_to}"
    end

    def schedule_callback
      # command MUST be like "#{schedule_id}__#{action}
      "schedule-%{command}%{return_to}"
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

    def options_translations_for(options, scope)
      # returns hash: { name: '.....', text: '....' }
      options.map do |option|
        I18n.t(option, scope: scope)
      end
    end

    # OPTIONS LISTS

    IN_SCHEDULE_OPTIONS = [
      :hide,
      :pin,
      :back
    ]

    MENU_OPTIONS = [
      :new_schedule,
      :my_schedules,
      :preferences
    ]

    OPTION_OPTIONS = [
      :change_option,
      :back
    ]

    PREFERENCES_OPTIONS = [
      :example_option_1,
      :back
    ]

    SCHEDULE_OPTIONS = [
      :show,
      :back
    ]
  end
end
