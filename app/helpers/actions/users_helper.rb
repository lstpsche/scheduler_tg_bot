# frozen_string_literal: true

module Helpers
  module Actions
    module UsersHelper
      def send_option_message(option_name, user, markup = nil)
        message_text = I18n.t("actions.users.options.#{option_name}.text")
        talker.send_or_edit_message(
          message_id: user.last_message_id, text: message_text,
          chat_id: user.id, markup: markup
        )
      end

      def setup_successfull
        talker.send_message(
          text: I18n.t('actions.users.preferences.setup_successful'),
          chat_id: chat_id,
          markup: 'remove'
        )
      end

      def show_options_menu
        options_kb = options_menu_inline_buttons

        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: options_kb)

        talker.send_or_edit_message(
          user: user, message_id: user.last_message_id, text: I18n.t('actions.users.preferences.show_options'),
          chat_id: chat_id, markup: markup
        )
      end

      def options_menu_inline_buttons(context: nil)
        options_kb = []

        Constants.options.each do |option|
          text = option[:button]
          callback = "preferences-#{option[:name]}" + ((context.nil? || context.strip.empty?) ? '' : "-#{context}")
          options_kb << Telegram::Bot::Types::InlineKeyboardButton.new(
            text: text, callback_data: callback
          )
        end

        options_kb
      end
    end
  end
end
