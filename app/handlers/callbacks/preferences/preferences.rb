# frozen_string_literal: true

module Handlers
  module Callbacks
    module Preferences
      class Preferences < Handlers::Callbacks::Base
        # attrs from base -- :bot, :chat_id, :user, :talker

        HANDLE_METHODS = {
          'back': :show_main_menu
        }.with_indifferent_access

        # 'initialize' is in base

        def handle(command)
          action = command.split('__').first

          super(action) do
            call_options_router_with(command)
          end
        end
      end
    end
  end
end
