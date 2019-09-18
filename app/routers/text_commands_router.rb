# frozen_string_literal: true

module Routers
  class TextCommandsRouter < Base
    include Helpers::Common
    include Helpers::TalkerActions
    include Helpers::MenusActions

    # attrs from base -- :bot, :chat_id, :user
    attr_reader :talker, :command

    # 'initialize' is in base

    def route(message)
      init_vars(message)
      return false if check_command_invalidity

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
      @talker = Talker.new(bot: bot, user: user)
    end

    ###########################################
    ###########################################
    ###########################################
    # TODO: move all this checks to a separate TextCommandValidityCheckService

    def command_exists?
      Constants.text_commands.include? command
    end

    def command_not_exists?
      !command_exists?
    end

    def command_syntax_valid?
      command.match(Constants.command_regex)
    end

    def command_syntax_invalid?
      !command_syntax_valid?
    end

    def check_command_validity
      (show_not_understand; return false) if command_syntax_invalid?
      (show_no_command; return false) if command_not_exists?
      (show_not_registered; return false) if registration_needed?

      true
    end

    def check_command_invalidity
      !check_command_validity
    end

    def registration_needed?
      command != '/start' && user_not_registered?(id: user.id)
    end
  end
end
