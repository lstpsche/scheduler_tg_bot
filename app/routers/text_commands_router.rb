# frozen_string_literal: true

module Routers
  class TextCommandsRouter < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :command

    # 'initialize' is in base

    def route(message)
      init_vars(message)
      return validation_service.errors if validation_service.failure?

      actual_command = command.split('/').last
      set_replace_last_false

      case actual_command
      # TODO: replace /main_menu with /start
      # TODO: on /start -- if user_registered? show main_menu, else - show "would you like to register?"
      when 'main_menu'
        show_main_menu
      when 'help'
        show_help
      end
    end

    private

    def init_vars(message)
      @command = message.text
      from = message.from
      @chat_id = from.id
      @user = get_user(chat_id: chat_id, fallback_user: from)
    end

    def validation_service
      @validation_service ||= Services::TextCommandValiditationService.new(user: user, command: command)
    end
  end
end
