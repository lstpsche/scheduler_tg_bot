# frozen_string_literal: true

module Actions
  module Features
    class Menu < Base
      attr_reader :bot, :chat_id, :talker, :user

      def initialize(bot:)
        @bot = bot
        @talker = Talker.new(bot: bot)
      end

      def show(chat_id:)
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)

        menu_options_kb = []
        Constants.menu_options.each do |menu_option_name|
          name = menu_option_name.split(' ').join('_')
          menu_options_kb << Telegram::Bot::Types::InlineKeyboardButton.new(
            text: I18n.t("actions.features.menu.#{name}"),
            callback_data: "menu-#{name}"
          )
        end
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: menu_options_kb)

        talker.send_or_edit_message(user: user, message_id: user.last_message_id,
                                    text: I18n.t('actions.features.menu.header'), chat_id: chat_id, markup: markup)
        user.update(replace_last_message: true)
      end
    end
  end
end
