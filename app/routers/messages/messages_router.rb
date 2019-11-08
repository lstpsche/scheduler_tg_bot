# frozen_string_literal: true

module Routers
  module Messages
    class MessagesRouter < Base
      # attrs from base -- :bot, :chat_id, :user

      ROUTERS = {
        'Message' => Routers::Messages::TextCommandsRouter,
        'CallbackQuery' => Routers::Messages::CallbacksRouter
      }.freeze

      # 'initialize' is in base

      def parse_message(message)
        ROUTERS[message_type(message)].new(bot: bot).route(message)
      end
    end
  end
end
