# frozen_string_literal: true

module Handlers
  module Callbacks
    module Preferences
      class Option < Handlers::Callbacks::Base
        # attrs from base -- :bot, :chat_id, :user, :talker

        HANDLE_METHODS = {
          'back': :call_back_option
        }.with_indifferent_access

        # 'initialize' is in base

        def handle(command)
          action = command.split('__').last

          super(action) do
            call_options_router_with(command)
          end
        end
      end
    end
  end
end
