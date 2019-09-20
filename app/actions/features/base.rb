# frozen_string_literal: true

module Actions
  module Features
    class Base
      include Helpers::Common
      include Helpers::TalkerActions
      include Helpers::MenusActions

      attr_reader :bot, :chat_id, :user

      def initialize(bot:, user:)
        @bot = bot
        @user = user
        @chat_id = user.id
      end

      def show
        markup = create_markup
        text = message_text

        send_or_edit_message(message_id: user.last_message_id, text: text, markup: markup)
        set_replace_last_true
      end

      def back
        set_replace_last_true
        show_main_menu
      end

      private

      def callback(command)
        command
      end

      def create_button(text, command)
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: text,
          callback_data: callback(command)
        )
      end

      def create_markup(options = [])
        kb = []
        options.each do |option|
          kb << create_button(option_button(option), option_name(option))
        end
        kb << yield if block_given?

        Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      end

      def option_button(option)
        option[:button]
      end

      def option_name(option)
        option[:name]
      end
    end
  end
end
