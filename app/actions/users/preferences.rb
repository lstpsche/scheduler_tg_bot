# frozen_string_literal: true

module Actions
  module Users
    class Preferences < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def show
        params = {
          markup_options: Constants.preferences_options
        }

        super(params)
      end

      def back
        show_main_menu
      end

      def setup_all
        setup_all_options
        save_validate_user { setup_successfull }
      end

      private

      def callback(option_name)
        Constants.preferences_callback % { option_name: option_name }
      end

      def message_text
        I18n.t('actions.users.preferences.show_options')
      end

      # 'option_name' is in base

      def setup_all_options
        # setup all options one by one
        options_to_setup.each do |option|
          setup_option(option_name(option))
        end
      end

      def options_to_setup
        # remove last 'option' which is actualy :back
        Constants.preferences_options[0..-2]
      end
    end
  end
end
