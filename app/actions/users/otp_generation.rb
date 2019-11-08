# frozen_string_literal: true

module Actions
  module Users
    class OTPGeneration < Base
      # attrs from base -- :bot, :chat_id, :user, :params

      # 'initialize' is in base

      def launch
        ask_if_needed
        return false if receive_response == 'no'

        otp_generation_request
      end

      private

      def ask_if_needed
        text = I18n.t('actions.users.otp.needed')
        send_message(text: text, markup: create_markup)
      end

      def create_markup
        super do
          [
            yes_button,
            no_button
          ]
        end
      end

      def yes_button
        create_button(name: 'yes', button_text: I18n.t('common.yes')).inline
      end

      def no_button
        create_button(name: 'no', button_text: I18n.t('common.no')).inline
      end
    end
  end
end
