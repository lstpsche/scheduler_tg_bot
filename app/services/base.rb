# frozen_string_literal: true

module Services
  class Base
    include Helpers::Common
    include Helpers::Menus::Actions
    include Helpers::Talker::Actions

    attr_reader :bot, :chat_id, :user

    def initialize(bot:, user:)
      @bot = bot
      @user = user
      @chat_id = user.id
    end
  end
end
