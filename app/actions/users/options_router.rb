# frozen_string_literal: true

module Actions
  module Users
    class OptionsRouter < Base
      # attrs from base -- :bot, :chat_id, :talker, :user

      # 'initialize' is in base

      def method_missing(method_name, *args, &block)
        action, option_name = method_name.to_s.split('_', 2)

        if option_name == 'back'
          back
        else
          send(action, option_name) if respond_to?(action)
        end
      end

      def show(option_name)
        Actions::Users::Option.new(bot: bot, user: user).show(option_name)
      end

      def setup(option_name)
        Services::OptionSetupService.new(bot: bot, user: user).setup(option_name)
      end

      def back
        Actions::Features::Menu.new(bot: bot, chat_id: chat_id).show
      end
    end
  end
end
