# frozen_string_literal: true

module Constants
  module Callbacks
    def add_schedule_callback
      'add_schedule-%{command}'
    end

    def all_schedules_callback
      'schedules-%{command}'
    end

    def create_schedule_callback
      'create_schedule-%{command}'
    end

    def main_menu_callback
      'menu-%{command}'
    end

    def option_callback
      'options-%{option_name}__%{action}'
    end

    def preferences_callback
      'preferences-%{command}__show'
    end

    def schedule_callback
      'schedule-%{schedule_id}__%{action}'
    end

    def schedule_setting_callback
      'schedule_setting-%{schedule_id}__%{option_name}__%{action}'
    end

    def schedule_settings_callback
      'schedule_settings-%{schedule_id}__%{setting_name}__show'
    end
  end
end
