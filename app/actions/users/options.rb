# frozen_string_literal: true

module Actions
  module Users
    class Options < Base
      attr_reader :bot, :chat_id, :response, :talker, :user

      def initialize(bot:, chat_id:)
        @bot = bot
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)
        @talker = Talker.new(bot: bot, user: user)
      end

      def example_option_1(user)
        option_send_message_get_response(option_name: __callee__.to_s)
        # set something up here
        # if user.save
        show_successfully_setup
        # else
        # show_something_wrong
        # end
      end

      def back
        Actions::Features::Menu.new(bot: bot).show(chat_id: chat_id)
      end

      private

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

      def option_send_message_get_response(option_name:, markup: nil)
        send_option_message(option_name, user, markup)

        get_response
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
