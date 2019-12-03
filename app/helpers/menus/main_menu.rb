# frozen_string_literal: true

module Helpers
  module Menus
    module MainMenu
      private

      def show_main_menu
        ::Actions::Features::MainMenu.new(bot: bot, user: user).show
      end

      def show_all_schedules
        ::Actions::Features::Schedules::AllSchedules.new(bot: bot, user: user).show
      end

      def show_preferences
        if ENV['RAILS_ENV'] == 'production'
          show_coming_soon
        else
          ::Actions::Users::Preferences.new(bot: bot, user: user).show
        end
      end
    end
  end
end
