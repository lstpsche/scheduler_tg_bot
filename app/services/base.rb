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

    def send_setting_message_and_receive_response
      send_setting_message
      receive_response
    end

    def setup_and_save(setting, value)
      @resource.send("#{setting}=", value)
      save_with_action { show_successfully_setup }
    end

    def save_with_action
      if @resource.save
        yield
      else
        show_something_wrong
        # TBD: maybe parse errors and show them to user
        # (rather no)
      end
    end

    def send_setting_message
      send_message(text: message_text)
    end

    def message_text
      raise NotImplementedError
    end
  end
end
