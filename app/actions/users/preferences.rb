# frozen_string_literal: true

module Actions
  module Users
    class Preferences < Actions::Users::Base
      # attrs from base -- :bot, :chat_id, :user, :params

      # 'initialize' is in base

      def show
        @params = Params.new(
          markup_options: Constant.preferences_options
        )

        super
      end

      def back
        show_main_menu
      end

      def setup_all
        setup_all_options
        save_validate_user { setup_successfull }
      end

      private

      def callback
        Constant.preferences_callback
      end

      def message_text
        I18n.t('actions.users.preferences.show_options')
      end

      # 'option_name' is in base

      def setup_all_options
        # setup all options one by one
        options_to_setup.each do |option|
          setup_option(option[:name])
        end
      end

      def options_to_setup
        # remove last 'option' which is actualy :back
        Constant.preferences_options[0..-2]
      end
    end
  end
end
