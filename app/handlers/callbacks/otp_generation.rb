# frozen_string_literal: true

module Handlers
  module Callbacks
    class OTPGeneration < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user

      HANDLE_METHODS = {
        'generate_otp': :generate_otp,
        'main_menu': :show_main_menu
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        reset_user_tapped_message
        super
      end
    end
  end
end
