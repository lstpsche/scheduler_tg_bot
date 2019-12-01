# frozen_string_literal: true

module Services
  class Base
    include Helpers::Common
    include Helpers::Menus::Actions
    include Helpers::Talker::Actions

    attr_reader :bot, :chat_id, :user

    SETTING_SETUP = {
      TrueClass: :toggle_bool_value,
      FalseClass: :toggle_bool_value,
      String: :setup_string_setting,
      NilClass: :setup_string_setting
    }.with_indifferent_access

    def initialize(bot:, user:)
      @bot = bot
      @user = user
      @chat_id = user.id
    end

    def setup(setting_name)
      class_name = resource.try(setting_name).class.to_s

      method(SETTING_SETUP[class_name]).call
    end

    private

    def toggle_bool_value
      new_value = !resource.try(@setting_name)

      setup_and_save(@setting_name, new_value, show_success: false)
    end

    def setup_string_setting
      reset_user_tapped_message
      send_setting_message
      response = receive_response_of_type('message')

      setup_and_save(@setting_name, response)
    end

    def setup_and_save(setting, value, show_success: true)
      resource.send("#{setting}=", value)
      save_with_action { show_successfully_setup if show_success }
    end

    def save_with_action
      if resource.save
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

    def resource
      raise NotImplementedError
    end

    def message_text
      raise NotImplementedError
    end
  end
end
