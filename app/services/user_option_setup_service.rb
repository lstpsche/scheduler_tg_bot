# frozen_string_literal: true

module Services
  class UserOptionSetupService < Services::Base
    include Helpers::Actions::OptionsSetups
    # attrs from base -- :bot, :chat_id, :talker, :user

    # 'initialize' is in base

    def perform(option_name)
      @option_name = option_name
      send_setting_message(@option_name)
      receive_response

      @user.send("#{@option_name}=", @response)

      save_action_user { show_successfully_setup }
    rescue NoMethodError
      show_not_setup
    end

    private

    def message_text
      I18n.t("actions.users.options.#{@option_name}.text")
    end

    def save_action_user
      if user.save
        yield
      else
        show_something_wrong
        # TBD: maybe parse errors and show them to user
        # (rather no)
      end
    end
  end
end
