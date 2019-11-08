# frozen_string_literal: true

module Services
  class TextCommandValidationService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :command, :success, :errors

    alias_method :success?, :success

    def initialize(bot:, chat_id:, command:)
      @bot = bot
      @chat_id = chat_id
      @command = command
      @errors = []
      @success = validate
    end

    def failure?
      !success
    end

    private

    def validate
      return not_registered if registration_needed?
      return bad_message unless message_valid
      return not_understand unless command_syntax_valid?
      return no_command unless command_exists?

      true
    end

    def message_valid
      !command.nil?
    end

    def command_syntax_valid?
      command.match(Constant.command_regex)
    end

    def command_exists?
      Constant.text_commands.include? command
    end

    def registration_needed?
      command != '/start' && !user_registered?(id: chat_id)
    end

    def bad_message
      errors << Error.new(code: 400, message: 'bad_input')
      false
    end

    def not_understand
      errors << Error.new(code: 400, message: 'not_understand')
      false
    end

    def no_command
      errors << Error.new(code: 501, message: 'no_command')
      false
    end

    def not_registered
      errors << Error.new(code: 401, message: 'not_registered')
      false
    end
  end
end
