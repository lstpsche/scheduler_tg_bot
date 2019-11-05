# frozen_string_literal: true

module Handlers
  module TextCommands
    class MenuHandler < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def handle
        show_main_menu
      end
    end
  end
end
