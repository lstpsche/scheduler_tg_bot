# frozen_string_literal: true

module Actions
  module Users
    class OTPGeneration < Actions::Users::Base
      # attrs from base -- :bot, :chat_id, :user, :params

      # 'initialize' is in base

      # 'show' is in base

      private

      def message_text
        I18n.t('actions.users.otp.question')
      end

      def create_markup
        super do
          yes_button
        end
      end

      def callback
        Constant.otp_generation_callback
      end

      def yes_button
        create_button(name: 'generate_otp', button_text: I18n.t('actions.users.otp.generate')).inline
      end
    end
  end
end
