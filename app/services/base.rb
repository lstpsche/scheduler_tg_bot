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

    private

    def send_setting_message(option_name)
      send_message(text: message_text)
    end

    def message_text
      raise NotImplementedError
    end
  end
end
