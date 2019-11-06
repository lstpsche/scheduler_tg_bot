# frozen_string_literal: true

module Services
  class OptionSetupService < Base
    include Helpers::Actions::OptionsSetups

    # attrs from base -- :bot, :chat_id, :talker, :user

    # 'initialize' is in base

    def perform(option_name)
      option_send_and_receive_response(option_name: option_name)

      # SET SOME SETTING UP IN THIS YIELD
      # yield if block_given?

      save_validate_user { show_successfully_setup }
    end

    private

    def option_send_and_receive_response(option_name:, markup: nil)
      send_option_message(option_name, user, markup)
      receive_response
    end
  end
end
