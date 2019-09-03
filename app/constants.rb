# frozen_string_literal: true

class Constants
  def self.command_regex
    /^\/(\w+)$/
  end

  def self.context_command_regex
    /^(\w+)-(\w+)(-(\w+))?$/
  end

  def self.options
    [
      'example_option_1'
    ]
  end

  def self.menu_options
    [
      'schedule',
      'my schedules',
      'preferences'
    ]
  end
end
