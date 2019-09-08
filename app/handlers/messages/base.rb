# frozen_string_literal: true

module Handlers
  module Messages
    class Base < Handlers::Base
      attr_reader :bot, :tg_user

      def initialize(bot:)
        @bot = bot
      end

      def call(message)
        text = message.text
        @tg_user = message.from

        if text.match(Constants.command_regex)
          parse_common_command(text)
        else
          parse_message_text(text)
        end
      end

      private

      def check_validity_of(command)
        if (command != '/start') && !User.find_by(id: tg_user.id)
          show_not_registered(tg_user.id)
          return false
        end
      end

      def parse_common_command(command)
        check_validity_of(command)

        parsed_command = command.match(Constants.command_regex)
        user = User.find_by(id: tg_user.id) || tg_user

        Handlers::Messages::Common::Base.new(bot: bot, chat_id: tg_user.id, user: user).(parsed_command[1])
      end

      def parse_message_text(command)
        Handlers::Messages::Text::Base.new(bot: bot, tg_user: tg_user).(command)
      end

      def show_not_registered(chat_id)
        Talker.show_not_registered(bot: bot, chat_id: chat_id)
      end
    end
  end
end
