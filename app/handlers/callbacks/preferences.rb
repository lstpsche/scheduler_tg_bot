# frozen_string_literal: true

module Handlers
  module Callbacks
    class Preferences < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user, :talker

      HANDLE_METHODS = {
        'back': :show_main_menu
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        action = command.split('__').first

        super(action) do
          Routers::Features::OptionsRouter.new(bot: bot, user: user).route(command)
        end
      end
    end
  end
end
