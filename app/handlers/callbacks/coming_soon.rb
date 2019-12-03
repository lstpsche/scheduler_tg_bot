# frozen_string_literal: true

module Handlers
  module Callbacks
    class ComingSoon < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user

      HANDLE_METHODS = {
        'back': :show_coming_soon_back
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        action, context = command.split('__')

        handler(action).call(context) if handler_exists_for?(action)
      end

      def show_coming_soon_back(context)
        method("show_#{context}").call
      end
    end
  end
end
