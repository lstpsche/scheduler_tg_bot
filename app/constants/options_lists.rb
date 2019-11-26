# frozen_string_literal: true

module Constants
  module OptionsLists
    def in_schedule_options_list
      %i[
        hide
        pin
        settings
        back
      ]
    end

    def menu_options_list
      %i[
        all_schedules
        preferences
      ]
    end

    def option_options_list
      %i[
        change_option
        back
      ]
    end

    def user_preferences_options_list
      %i[
        example_option_1
        back
      ]
    end

    def schedule_options_list
      %i[
        show
        settings
        back
      ]
    end

    def schedule_setting_options_list
      with_back([:change_setting])
    end

    def schedule_settings_list
      %i[
        example_option
      ]
    end

    def schedule_settings_options_list
      with_back(schedule_settings_list)
    end

    def with_back(list)
      list + [:back]
    end
  end
end
