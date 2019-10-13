# frozen_string_literal: true

module Actions
  module Users
    class OTPGeneration < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def launch
        ask_if_needed
        return false if get_response == 'no'

        otp_generation_request
        return true
      end

      private

      def ask_if_needed
        text = I18n.t('actions.users.otp.needed')
        markup = create_markup(buttons)
        send_message(text: text, markup: markup)
      end

      def buttons
        [
          { name: 'yes', button: I18n.t('common.yes') },
          { name: 'no', button: I18n.t('common.no') }
        ]
      end

      def create_markup(options)
        kb = []
        kb << create_button(option_button(options[0]), option_name(options[0]))
        kb << create_button(option_button(options[1]), option_name(options[1]))

        Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      end
    end
  end
end
