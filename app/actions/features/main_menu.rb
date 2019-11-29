# frozen_string_literal: true

module Actions
  module Features
    class MainMenu < Actions::Features::Base
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
        Decorators::MenuDecorator.decorate(
          { menu: 'main_menu' },
          I18n.t('actions.features.menu.header')
        )
      end
    end
  end
end
