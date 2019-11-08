# frozen_string_literal: true

module Routers
  module Messages
    class TextCommandsRouter < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :message

      HANDLERS = {
        'start' => Handlers::TextCommands::StartHandler,
        'menu' => Handlers::TextCommands::MenuHandler,
        'help' => Handlers::TextCommands::HelpHandler
      }.freeze

      # 'initialize' is in base

      def route(message)
        @message = message
        init_vars
        raise validation_service.errors.first if validation_service.failure?

        call_handler_with(command)
      end

      private

      def init_vars
        @user = get_user(chat_id: tg_user.id, fallback_user: tg_user)
        @chat_id = user.id
        reset_user_tapped_message if user.try(:tapped_message).present?
      end

      def validation_service
        @validation_service ||= Services::TextCommandValidationService.new(bot: bot, chat_id: chat_id, command: command)
      end

      def call_handler_with(command)
        actual_command = command.split('/').last
        HANDLERS[actual_command].new(bot: bot, chat_id: chat_id, user: user).handle
      end

      def command
        message.text
      end

      def tg_user
        message.from
      end
    end
  end
end
