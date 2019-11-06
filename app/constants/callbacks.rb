# frozen_string_literal: true

module Constants
  module Callbacks
    def add_schedule_callback
      'add_schedule-%{schedule_id}'
    end

    def all_schedules_callback
      'schedules-%{command}'
    end

    def main_menu_callback
      'menu-%{command}'
    end

    def option_callback
      'options-%{option_name}__%{action}'
    end

    def preferences_callback
      'preferences-%{option_name}__show'
    end

    def schedule_callback
      'schedule-%{schedule_id}__%{action}'
    end
  end
end
