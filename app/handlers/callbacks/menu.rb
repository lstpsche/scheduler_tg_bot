# frozen_string_literal: true

module Handlers
  module Callbacks
    class Menu < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user

      HANDLE_METHODS = {
        'all_schedules': :show_all_schedules,
        'preferences': :show_preferences
      }.with_indifferent_access

      # 'initialize' is in base

      # 'handle' is in base
    end
  end
end
