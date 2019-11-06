# frozen_string_literal: true

module Constants
  module Options
    include Constants::OptionsLists

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

      # options_translations_for(NEW_OPTIONS, new_options_scope) +
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
  end
end
