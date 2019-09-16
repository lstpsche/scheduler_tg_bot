# frozen_string_literal: true

module Actions
  module Users
    class Preferences < Base
      # attrs from base -- :bot, :chat_id, :talker, :user
      attr_reader :options_router

      def initialize(bot:, chat_id: nil, user: nil)
        super
        @options_router = OptionsRouter.new(bot: bot, chat_id: @chat_id)
      end

      def show
        setup_all_options
        save_validate_user { setup_successfull }
      end

      # 'back' is in base

      def show_options
        show_options_menu
      end

      private

      # 'option_name' is in base

      def setup_all_options
        # setup all options one by one
        Constants.preferences_options.each do |option|
          options_router.setup(option_name(option))
        end
      end
    end
  end
end
