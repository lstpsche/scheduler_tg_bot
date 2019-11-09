# frozen_string_literal: true

module Handlers
  module Callbacks
    class Base < Handlers::Base
      # Helpers::Common
      # Helpers::Menus::Actions
      # Helpers::Talker::Actions

      # attrs from base -- :bot, :chat_id, :user
      attr_reader :talker

      def initialize(bot:, user:)
        @bot = bot
        @chat_id = user.id
        @user = user
      end
    end
  end
end
