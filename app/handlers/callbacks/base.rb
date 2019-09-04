# frozen_string_literal: true

module Handlers
  module Callbacks
    class Base < Handlers::Base
      CLASS_INDEX = 1           # ex. preferences
      COMMAND_INDEX = 2         # command
      DIRTY_CONTEXT_INDEX = 3   # with "-" sign before (ex. '-main_menu')
      CONTEXT_INDEX = 4         # ex. main_menu

      attr_reader :bot, :parsed_command, :user_id

      def initialize(bot:)
        @bot = bot
      end

      def call(callback)
        init_vars(callback)
        parse_context_command(callback.data)

        call_handler(parsed_command[COMMAND_INDEX])

        return_to_context(parsed_command[CONTEXT_INDEX])
      end

      private

      def init_vars(callback)
        @user_id = callback.from.id
      end

      def parse_context_command(command)
        @parsed_command = command.match(Constants.context_command_regex) # /^(\w+)-(\w+)(-(\w+))?$/
      end

      def call_handler(command)
        option_klass = parsed_command[CLASS_INDEX].split('_').map(&:capitalize).join
        handler = "Handlers::Messages::Common::#{option_klass}".split('::').reduce(Module, :const_get)
        binding.pry

        handler.new(bot: bot, chat_id: user_id, user: User.find_by(id: user_id)).(command)
      end

      def return_to_context(context)
        case context
        when 'options_menu'
          show_options_menu
        when 'main_menu'
          show_main_menu
        end
      end

      def show_options_menu
        Actions::Users::Preferences.new(bot: bot, chat_id: user_id).show_options_menu
      end

      def show_main_menu
        Actions::Features::Menu.new(bot: bot).show(chat_id: user_id)
      end
    end
  end
end
