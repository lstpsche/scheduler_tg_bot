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

    def set_schedule_name_full_layout
      /(.+)--(.+)/
    end

    def set_schedule_name_layout_without_add_info
      /(.+)/
    end

    # TODO: remove whitespaces around --
    def day_event_full_layout
      /^(\d+:\d+) (.+) -- (.+)$/
    end

    def day_event_layout_without_add_info
      /^(\d+:\d+) (.+)$/
    end

    def event_in_schedule_decoration
      "*%{time}*: %{info} _(%{additional_info})_"
    end

    # OPTIONS

    def in_schedule_options
      scope = 'actions.features.schedules.schedule.options'

      options_translations_for(IN_SCHEDULE_OPTIONS, scope)
    end

    def option_options
      scope = 'actions.users.option'

      options_translations_for(OPTION_OPTIONS, scope)
    end

    def preferences_options
      scope = 'actions.users.options'

      # options_translations_for(NEW_OPTIONS, new_scope) +
      options_translations_for(USER_PREFERENCES_OPTIONS, scope)
    end

    def schedule_options
      scope = 'actions.features.schedules.schedule.options'

      options_translations_for(SCHEDULE_OPTIONS, scope)
    end

    def menu_options
      scope = 'actions.features.menu'

      options_translations_for(MENU_OPTIONS, scope)
    end

    # CALLBACKS

    def main_menu_callback
      'menu-%{command}'
    end

    def my_schedules_callback
      'my_schedules-%{command}'
    end

    def option_callback
      'options-%{option_name}__%{action}'
    end

    def preferences_callback
      'preferences-%{option_name}__show'
    end

    def schedule_callback
      # TODO: command MUST be like "#{schedule_id}__#{action}
      'schedule-%{command}'
    end

    # using for inner coding. no need to translate

    def text_commands
      [
        '/start',
        '/help'
      ]
    end

    def weekdays
      [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ]
    end

    def translated_weekdays
      weekdays.map do |weekday|
        I18n.t("weekdays.#{weekday}")
      end
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

    USER_PREFERENCES_OPTIONS = [
      :example_option_1,
      :back
    ]

    SCHEDULE_OPTIONS = [
      :show,
      :back
    ]
  end
end
