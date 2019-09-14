# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      class Preferences < Base
        attr_reader :bot, :chat_id, :user, :options

        def initialize(bot:, chat_id:, user:)
          @bot = bot
          @chat_id = chat_id
          @options = Actions::Users::Options.new(bot: bot, chat_id: chat_id)
          @user = user
        end

        def method_missing(method_name, *args, &block)
          options.send(method_name, user)
        end

        def back
          user.update(replace_last_message: true)
          options.back
        end
      end
    end
  end
end
