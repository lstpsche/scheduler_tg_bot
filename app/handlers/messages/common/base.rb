# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      class Base < Handlers::Base
        attr_reader :bot, :chat_id, :user

        def initialize(bot:, chat_id:, user:)
          @bot = bot
          @chat_id = chat_id
          @user = user
        end

        def call(command)
          send(command)
        end

        def start
          return false if user_registered?(id: chat_id)

          ::Actions::Users::Registration.new(bot: bot, tg_user: user).launch
          Talker.send_shorten_help_message(bot: bot, chat_id: chat_id)
        end

        def main_menu
          unless user_registered?(id: chat_id)
            Talker.show_not_registered(bot: bot, chat_id: chat_id)
            return false
          end

          ::Actions::Features::Menu.new(bot: bot).show(chat_id: chat_id)
        end

        def preferences
          return false unless user_registered?(id: chat_id)

          ::Actions::Users::Preferences.new(bot: bot, chat_id: chat_id).show_options
        end

        def help
          Talker.send_help_message(bot: bot, chat_id: chat_id)
        end
      end
    end
  end
end
