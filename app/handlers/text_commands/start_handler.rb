# frozen_string_literal: true

module Handlers
  module TextCommands
    class StartHandler < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def handle
        if user_registered?(id: chat_id)
          start_registered
        else
          start_not_registered
        end
      end

      private

      def start_registered
        show_welcome_message if user.first_start_message?
        show_main_menu
      end

      def start_not_registered
        register_user
        show_welcome_message
        show_otp_generation_question
        show_help_message
      end
    end
  end
end
