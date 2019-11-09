# frozen_string_literal: true

module Handlers
  class Base
    include Helpers::Common
    include Helpers::Menus::Actions
    include Helpers::Talker::Actions

    attr_reader :bot, :chat_id, :user

    def initialize(bot:, user:)
      @bot = bot
      @chat_id = user.id
      @user = user
    end
  end
end
