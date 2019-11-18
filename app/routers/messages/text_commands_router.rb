# frozen_string_literal: true

module Routers
  module Messages
    class TextCommandsRouter < Routers::Messages::Base
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
        user = tg_user
        @chat_id = user.id
        @user = get_user(chat_id: chat_id, fallback_user: user)
        update_language_code(user.language_code)
        reset_user_tapped_message
      end

      def validation_service
        @validation_service ||= Services::TextCommandValidationService.new(bot: bot, chat_id: chat_id, command: command)
      end

      def call_handler_with(command)
        actual_command = command.split('/').last
        HANDLERS[actual_command].new(bot: bot, user: user).handle
      end

      def user
        @user ||= get_user(chat_id: tg_user.id, fallback_user: tg_user)
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
