# frozen_string_literal: true

module Helpers
  module Menus
    module Actions
      include Helpers::Menus::Registration
      include Helpers::Menus::MainMenu
      include Helpers::Menus::Schedules
      include Helpers::Menus::Preferences
    end
  end
end
