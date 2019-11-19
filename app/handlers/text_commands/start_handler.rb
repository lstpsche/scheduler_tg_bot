# frozen_string_literal: true

module Handlers
  module TextCommands
    class StartHandler < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def handle
        if user_registered?(id: chat_id)
          show_welcome_message if user.first_start_message?
          show_main_menu
        else
          register_user
          show_welcome_message
          show_otp_generation_question
          show_help_message
        end
      end
    end
  end
end
