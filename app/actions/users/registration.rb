# frozen_string_literal: true

module Actions
  module Users
    class Registration < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :tg_user

      def initialize(bot:, tg_user:)
        @bot = bot
        @tg_user = tg_user
        @chat_id = tg_user.id
      end

      def show
        @user = DB.create_user(tg_user: tg_user)

        send_message(text: message_text)

        setup_all_preferences
        show_main_menu unless need_generate_otp
      end

      alias :launch :show

      # Registration has no 'back' button
      def back
        raise NoMethodError
      end

      private

      def message_text
        I18n.t('actions.users.registration.welcome') % { name: user.first_name }
      end
    end
  end
end
