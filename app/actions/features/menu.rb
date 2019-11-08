# frozen_string_literal: true

module Actions
  module Features
    class Menu < Base
      # attrs from base -- :bot, :chat_id, :user, :params

      # 'initialize' is in base

      def show
        @params = Params.new(
          markup_options: Constant.menu_options
        )

        super
      end

      private

      def callback
        Constant.main_menu_callback
      end

      def message_text
        I18n.t('actions.features.menu.header')
      end

      # 'create_button' is in base
      # 'create_markup' is in base
      # 'button_args' is in base
    end
  end
end
