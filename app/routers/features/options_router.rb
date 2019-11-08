# frozen_string_literal: true

module Routers
  module Features
    class OptionsRouter < Base
      # attrs from base -- :bot, :chat_id, :user

      def initialize(bot:, user: nil)
        super(bot: bot)
        @user = user
        @chat_id = user.id
      end

      def route(command)
        option_name, action = command.split('__')

        case action
        when 'show'
          option_name == 'back' ? back : show(option_name)
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

      def back
        show_main_menu
      end
    end
  end
end
