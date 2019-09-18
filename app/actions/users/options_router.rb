# frozen_string_literal: true

module Actions
  module Users
    class OptionsRouter < Base
      # attrs from base -- :bot, :chat_id, :talker, :user

      # 'initialize' is in base

      # TODO: replace with route()
      def method_missing(method_name, *args, &block)
        action, option_name = method_name.to_s.split('_', 2)

        if option_name == 'back'
          back
        else
          send(action, option_name) if respond_to?(action)
        end
      end

      def show(option_name)
        show_option(option_name)
      end

      def setup(option_name)
        setup_option(option_name)
      end

      def back
        show_main_menu
      end
    end
  end
end
