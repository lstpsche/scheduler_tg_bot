# frozen_string_literal: true

module Handlers
  module Callbacks
    class Menu < Base
      # attrs from base -- :bot, :chat_id, :user

      HANDLE_METHODS = {
        'all_schedules': :show_all_schedules,
        'preferences': :show_preferences
      }.with_indifferent_access

      # 'initialize' is in base

      def handle(command)
        raise Error.new(code: 400, message: 'Not understand') unless handler_exists_for?(command)

        method(HANDLE_METHODS[command]).call
      end

      def handler_exists_for?(command)
        HANDLE_METHODS.keys.include?(command)
      end
    end
  end
end
