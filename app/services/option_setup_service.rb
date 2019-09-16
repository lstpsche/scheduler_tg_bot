# frozen_string_literal: true

module Services
  class OptionSetupService < Base
    include Helpers::Actions::UsersHelper
    include Helpers::Actions::OptionsSetups

    # attrs from base -- :bot, :chat_id, :talker, :user
    attr_reader :option

    def initialize(params)
      super(params) do
        @option = Actions::Users::Option.new(bot: bot, user: user)
      end
    end

    def perform(option_name)
      option_send_and_get_response(option_name: option_name)

      # SET SOME SETTING UP IN THIS YIELD
      # yield if block_given?

      save_validate_user { show_successfully_setup }

      set_replace_last_false
      option.show(option_name)
    end

    private

    def option_send_and_get_response(option_name:, markup: nil)
      send_option_message(option_name, user, markup)
      get_response
    end
  end
end
