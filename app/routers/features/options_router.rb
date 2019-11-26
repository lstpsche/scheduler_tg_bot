# frozen_string_literal: true

module Routers
  module Features
    class OptionsRouter < Base
      # attrs from base -- :bot, :chat_id, :user

      def initialize(bot:, user:)
        super(bot: bot)
        @user = user
        @chat_id = user.id
      end

      def route(command)
        option_name, action = command.split('__')

        case action
        when 'show'
          show(option_name)
        when 'setup'
          setup(option_name)
        end
      end

      def show(option_name)
        show_option(option_name)
      end

      def setup(option_name)
        setup_option(option_name)
        reset_user_tapped_message
        show_option(option_name)
      end
    end
  end
end
