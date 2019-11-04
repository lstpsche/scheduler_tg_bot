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
        send_message(text: text, markup: create_markup)
      end

      def create_markup
        yes_button = { name: 'yes', button: I18n.t('common.yes') }
        no_button = { name: 'no', button: I18n.t('common.no') }

        super do
          [
            create_button(option_button(yes_button), option_name(yes_button)),
            create_button(option_button(no_button), option_name(no_button))
          ]
        end
      end
    end
  end
end