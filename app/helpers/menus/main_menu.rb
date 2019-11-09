# frozen_string_literal: true

module Helpers
  module Menus
    module MainMenu
      private

      def show_main_menu
        ::Actions::Features::Menu.new(bot: bot, user: user).show
      end

      def show_all_schedules
        ::Actions::Features::Schedules::AllSchedules.new(bot: bot, user: user).show
      end

      def show_preferences
        ::Actions::Users::Preferences.new(bot: bot, user: user).show
      end
    end
  end
end
