# frozen_string_literal: true

module Actions
  module Users
    class Options < Base
      attr_reader :bot, :chat_id, :response, :talker, :user

      def initialize(bot:, chat_id:)
        @bot = bot
        @chat_id = chat_id
        @talker = Talker.new(bot: bot)
      end

      def example_option_1(user)
        option_send_message_get_response(option_name: __callee__.to_s)
        # set something up here
      end

      private

      def option_send_message_get_response(option_name:, markup: nil)
        send_option_message(option_name, chat_id, markup)

        get_response
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
    end
  end
end
