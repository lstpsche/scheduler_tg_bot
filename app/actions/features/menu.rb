# frozen_string_literal: true

module Actions
  module Features
    class Menu < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def show
        params = {
          markup_options: Constants.menu_options
        }

        super(params)
      end

      private

      def callback(command)
        Constants.main_menu_callback % {
          command: command,
          return_to: nil
        }
      end

      def message_text
        I18n.t('actions.features.menu.header')
      end

      # 'create_button' is in base
      # 'create_markup' is in base
      # 'option_button' is in base
      # 'option_name' is in base
    end
  end
end
