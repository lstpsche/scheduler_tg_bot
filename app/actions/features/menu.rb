# frozen_string_literal: true

module Actions
  module Features
    class Menu < Actions::Features::Base
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
    end
  end
end
