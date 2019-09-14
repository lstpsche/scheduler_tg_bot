# frozen_string_literal: true

module Actions
  module Users
    class Options < Base
      attr_reader :bot, :chat_id, :option_class, :talker, :user

      def initialize(bot:, chat_id:)
        @bot = bot
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)
        @talker = Talker.new(bot: bot, user: user)
        @option_class = Actions::Users::Option.new(bot: bot, user: user)
      end

      def method_missing(method_name, *args, &block)
        splitted_method = method_name.to_s.split('_')
        action = splitted_method.first
        option_name = splitted_method[1..-1].join('_')

        if option_name == 'back'
          back
        else
          send(action, option_name) if respond_to?(action)
        end
      end

      def show(option_name)
        option_class.show(option_name)
      end

      def setup(option_name)
        option_class.send("setup_#{option_name}")
      end

      def back
        Actions::Features::Menu.new(bot: bot, chat_id: chat_id).show
      end
    end
  end
end
