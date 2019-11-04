# frozen_string_literal: true

module Handlers
  module Callbacks
    class Options < Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      # 'initialize' is in base

      def handle(command)
        back && return if command.split('__').last == 'back'

        Routers::Features::OptionsRouter.new(bot: bot, user: user).route(command)
      end

      def back
        call_back_option
      end
    end
  end
end
