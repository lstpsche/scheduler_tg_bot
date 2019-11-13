# frozen_string_literal: true

module Handlers
  module Callbacks
    class Options < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      HANDLE_METHODS = {
        'back': :call_back_option
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        action = command.split('__').last

        super(action) do
          Routers::Features::OptionsRouter.new(bot: bot, user: user).route(command)
        end
      end
    end
  end
end
