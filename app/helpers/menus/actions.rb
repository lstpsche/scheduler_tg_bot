# frozen_string_literal: true

module Helpers
  module Menus
    module Actions
      include Helpers::Menus::Registration
      include Helpers::Menus::MainMenu
      include Helpers::Menus::Schedules
      include Helpers::Menus::Preferences

      def show_coming_soon(back_to: 'main_menu')
        ::Actions::ComingSoon.new(bot: bot, user: user).show(back_to: back_to)
      end
    end
  end
end
