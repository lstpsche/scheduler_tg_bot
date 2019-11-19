# frozen_string_literal: true

module Helpers
  module Menus
    module Preferences
      private

      ################# Preferences ##################################

      def show_option(option_name)
        ::Actions::Users::Option.new(bot: bot, user: user).show(option_name)
      end

      ################# Options ######################################

      def setup_option(option_name)
        ::Services::OptionSetupService.new(bot: bot, user: user).perform(option_name)
      end

      def call_back_option
        ::Actions::Users::Option.new(bot: bot, user: user).back
      end
    end
  end
end
