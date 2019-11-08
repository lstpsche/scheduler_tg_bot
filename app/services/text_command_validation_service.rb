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

    CHECKS = {
      registration_not_needed?: :not_registered,
      message_valid?: :bad_message,
      command_syntax_valid?: :not_understand,
      command_exists?: :no_command
    }.with_indifferent_access

    def validate
      CHECKS.each { |check, callback| return send(callback) unless send(check) }

      true
    end

    def message_valid?
      !command.nil?
    end

    def command_syntax_valid?
      command.match(Constant.command_regex)
    end

    def command_exists?
      Constant.text_commands.include? command
    end

    def registration_not_needed?
      user_registered?(id: chat_id) || command == '/start'
    end

    def bad_message
      errors << Error.new(code: 400, message: 'Bad input')
      false
    end

    def not_understand
      errors << Error.new(code: 400, message: 'Not understand')
      false
    end

    def no_command
      errors << Error.new(code: 501, message: 'No command')
      false
    end

    def not_registered
      errors << Error.new(code: 401, message: 'Not registered')
      false
    end
  end
end
