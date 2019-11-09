# frozen_string_literal: true

module Helpers
  module Talker
    module CommonActions
      private

      def receive_message
        talker.receive_message
      end

      def receive_response
        # THIS RESPONSE CAN BE FROM ANOTHER PERSON
        # SHOULD TEST IT AND MAYBE ADD CHECKER, IF RESPONSE IS FROM NEEDED USER
        @response = receive_message

        message_data_from(@response)
      end

      def receive_response_of_type(type)
        loop do
          response = receive_message
          return message_data_from(response) if message_is_a?(type, response)
        end
      end

      def send_message(text:, markup: nil)
        talker.send_message(text: text, markup: markup)
      end

      def edit_message(message_id:, text:, markup: nil)
        talker.edit_message(message_id: message_id, text: text, markup: markup)
      end

      def edit_message_reply_markup(message_id:, reply_markup: nil)
        talker.edit_message_reply_markup(message_id: message_id, reply_markup: reply_markup)
      end

      def send_or_edit_message(message_id: nil, text: nil, markup: nil)
        talker.send_or_edit_message(message_id: message_id, text: text, markup: markup)
      end

      def setup_successfull
        send_message(
          text: I18n.t('actions.users.preferences.setup_successful'),
          markup: 'remove'
        )
      end

      def show_successfully_setup
        send_message(
          text: I18n.t('actions.users.options.setup_successful'),
          markup: 'remove'
        )
      end
    end
  end
end
