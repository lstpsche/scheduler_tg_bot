# frozen_string_literal: true

module Actions
  module Users
    class Registration < Base
      # attrs from base -- :bot, :chat_id, :talker, :user

      # 'initialize' is in base
      # 'show' is in base
      # 'back' is in base

      private

      def before_show(*args)
        @user = DB.create_user(tg_user: user)
      end

      def after_show(*args)
        setup_all_preferences
      end

      def message_text
        I18n.t('actions.users.registration.welcome') % { name: user.first_name }
      end
    end
  end
end
