# frozen_string_literal: true

module Handlers
  module Callbacks
    class CreateSchedule < Handlers::Callbacks::Base
      # attrs from base -- :bot, :chat_id, :user

      HANDLE_METHODS = {
        'back': :show_add_schedule
      }.with_indifferent_access

      # 'initialize' is in base

      # 'handle' is in base
    end
  end
end
