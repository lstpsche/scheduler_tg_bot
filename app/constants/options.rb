# frozen_string_literal: true

module Constants
  module Options
    include Constants::OptionsLists

    def in_schedule_options
      scope = 'actions.features.schedules.schedule.options'

      options_translations_for(in_schedule_options_list, scope) + back_button
    end

    def option_options
      scope = 'actions.users.option'

      options_translations_for(option_options_list, scope) + back_button
    end

    def preferences_options
      scope = 'actions.users.options'

      # options_translations_for(NEW_OPTIONS, new_options_scope) +
      options_translations_for(user_preferences_options_list, scope) + back_button
    end

    def schedule_options
      scope = 'actions.features.schedules.schedule.options'

      options_translations_for(schedule_options_list, scope) + back_button
    end

    def schedule_setting_options
      scope = 'actions.features.schedules.schedule_setting.options'

      options_translations_for(schedule_setting_options_list, scope) + back_button
    end

    def schedule_settings_options
      scope = 'actions.features.schedules.schedule_settings.options'

      options_translations_for(schedule_settings_list, scope) + back_button
    end

    def menu_options
      scope = 'actions.features.menu'

      options_translations_for(menu_options_list, scope)
    end
  end
end
