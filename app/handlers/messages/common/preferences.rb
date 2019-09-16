# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      class Preferences < Base
        attr_reader :bot, :chat_id, :user, :options_router

        def initialize(bot:, chat_id:, user:)
          @bot = bot
          @chat_id = chat_id
          @user = user
          @options_router = Actions::Users::OptionsRouter.new(bot: bot, user: user)
        end

        def method_missing(method_name, *args, &block)
          options_router.send(method_name)
        end

        def back
          user.update(replace_last_message: true)
          options_router.back
        end
      end
    end
  end
end
