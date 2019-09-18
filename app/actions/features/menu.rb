# frozen_string_literal: true

module Actions
  module Features
    class Menu < Base
      # attrs from base -- :bot, :chat_id, :talker, :user
      # 'initialize' is in base
      # 'show' method is in base

      # there is no 'back' in Main Menu
      def back
        raise NoMethodError
      end

      private

      def callback(command)
        Constants.main_menu_callback % {
          command: command,
          return_to: nil
        }
      end

      # create_button is in base

      def create_markup
        super(Constants.menu_options)
      end

      def message_text
        I18n.t('actions.features.menu.header')
      end

      # option_button is in base
      # option_name is in base
    end
  end
end
