# frozen_string_literal: true

module Helpers
  module Actions
    module UsersHelper
      def get_response
        # THIS RESPONSE CAN BE FROM ANOTHER PERSON
        # SHOULD TEST IT AND MAYBE ADD CHECKER, IF RESPONSE IS FROM NEEDED USER
        @response = get_message

        case @response
        when Telegram::Bot::Types::Message
          return @response.text
        when Telegram::Bot::Types::CallbackQuery
          return @response.data
        end
      end

      def send_option_message(option_name, user, markup = nil)
        message_text = I18n.t("actions.users.options.#{option_name}.text")
        send_or_edit_message(
          message_id: user.last_message_id, text: message_text,
          markup: markup
        )
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
