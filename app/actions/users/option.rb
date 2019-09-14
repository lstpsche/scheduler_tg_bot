# frozen_string_literal: true

module Actions
  module Users
    class Option < Base
      attr_reader :bot, :chat_id, :talker, :response, :user

      def initialize(bot:, user:)
        @bot = bot
        @chat_id = user.id
        @user = user
        @talker = Talker.new(bot: bot, user: user)
      end

      def back
        Actions::Users::Preferences.new(bot: bot, user: user).show_options
      end

      def show(option_name)
        text = option_view_text(option_name)
        talker.send_or_edit_message(user: user, message_id: user.last_message_id,
                                    text: text, chat_id: chat_id,
                                    markup: create_option_options_markup(option_name))
        user.update(replace_last_message: true)
      end

      def setup(option_name)
        option_send_message_get_response(option_name: option_name)
        # SET SOMETHING UP HERE
        # if user.save
        show_successfully_setup
        # else
        # show_something_wrong
        # end
        user.update(replace_last_message: false)
        show(option_name)
      end

      def setup_example_option_1
        setup('example_option_1')
      end

      private

      def create_button(text, callback, option_name)
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: text,
          callback_data: option_button_callback_data(callback, option_name)
        )
      end

      def create_option_options_markup(option_name)
        option_options_kb = []
        Constants.option_options.each do |option_opt|
          option_options_kb << create_button(option_opt[:button], option_opt[:name], option_name)
        end

        Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: option_options_kb)
      end

      def get_response
        # THIS RESPONSE CAN BE FROM ANOTHER PERSON
        # SHOULD TEST IT AND MAYBE ADD CHECKER, IF RESPONSE IS FROM NEEDED USER
        @response = talker.get_message

        case response
        when Telegram::Bot::Types::Message
          return response.text
        when Telegram::Bot::Types::CallbackQuery
          return response.data
        end
      end

      def option_button_callback_data(command, option_name)
        Constants.option_callback % {
          command: "#{command}_#{option_name}",
          return_to: nil
        }
      end

      def option_send_message_get_response(option_name:, markup: nil)
        send_option_message(option_name, user, markup)

        get_response
      end

      def option_view_text(option)
        option_name = option.split('_').map(&:capitalize).join(' ')
        user_option = user&.send(option)
        user_option_text = if user_option
          "_Current state:_ " + user_option
        else
          'This setting was not set for you yet.'
        end

        "*#{option_name}*\n#{user_option_text}"
      end

      def show_successfully_setup
        Talker.send_message(
          bot: bot,
          text: I18n.t('actions.users.options.setup_successful'),
          chat_id: chat_id,
          markup: 'remove'
        )
      end
    end
  end
end
