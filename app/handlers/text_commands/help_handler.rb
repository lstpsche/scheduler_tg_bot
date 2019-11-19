# frozen_string_literal: true

module Handlers
  module TextCommands
    class HelpHandler < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def handle
        show_help_message
      end
    end
  end
end
