# frozen_string_literal: true

module Actions
  module Features
    class Base
      attr_reader :bot, :chat_id, :talker, :user

      def initialize(bot:, chat_id:)
        @bot = bot
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)
        @talker = Talker.new(bot: bot, user: user)
      end

      def show
        markup = create_markup
        text = message_text

        talker.send_or_edit_message(user: user, message_id: user.last_message_id,
                                    text: text, chat_id: chat_id, markup: markup)
        set_replace_last_true
      end

      def back
        set_replace_last_true
        Handlers::Messages::Common::Base.new(bot: bot, chat_id: chat_id, user: user).main_menu
      end

      protected

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

      def set_replace_last_true
        user.update(replace_last_message: true)
      end

      def set_replace_last_false
        user.update(replace_last_message: false)
      end
    end
  end
end
