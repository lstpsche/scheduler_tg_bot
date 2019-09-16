# frozen_string_literal: true

module Actions
  module Users
    class Base
      include Helpers::Common
      include Helpers::Actions::UsersHelper

      attr_reader :bot, :chat_id, :talker, :user

      # TODO: REWRITE TO ACCEPT ONLY USER
      def initialize(bot:, chat_id: nil, user: nil)
        return unless params_valid?(chat_id, user)

        @bot = bot
        @chat_id = chat_id || user.id
        @user = user || User.find_by(id: chat_id)

        @talker = Talker.new(bot: bot, user: @user)
      end

      def show(args = {})
        before_show(args.fetch(:before, nil))

        talker.send_or_edit_message(
          user: user, message_id: user.last_message_id,
          text: message_text, chat_id: chat_id,
          markup: create_markup(args.fetch(:markup_options, nil))
        )

        after_show(args.fetch(:after, nil))
      end

      def back
        set_replace_last_true
        Actions::Features::Menu.new(bot: bot, chat_id: chat_id, user: user).show
      end

      private

      def before_show(*args); end
      def after_show(*args); end

      def callback(command)
        command
      end

      def create_button(text, callback)
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: text,
          callback_data: callback(callback)
        )
      end

      def create_markup(options)
        return unless options

        kb = []
        options.each do |option|
          kb << create_button(option_button(option), option_name(option))
        end

        Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      end

      def message_text
        raise NotImplementedError
      end

      def option_button(option)
        option[:button]
      end

      def option_name(option)
        option[:name]
      end

      def params_valid?(chat_id, user)
        chat_id || user
      end
    end
  end
end
