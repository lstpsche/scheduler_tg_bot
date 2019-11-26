# frozen_string_literal: true

module Services
  class UserOptionSetupService < Services::Base
    include Helpers::Actions::OptionsSetups
    # attrs from base -- :bot, :chat_id, :talker, :user

    # 'initialize' is in base

    def perform(option_name)
      @setting_name = option_name
      @resource = @user
      send_setting_message_and_receive_response

      setup_and_save(@setting_name, @response)
    rescue NoMethodError
      show_not_setup
    end

    private

    def message_text
      I18n.t("actions.users.options.#{@setting_name}.text")
    end
  end
end
