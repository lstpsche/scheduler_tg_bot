# frozen_string_literal: true

module Actions
  module Users
    class Registration < Base
      # attrs from base -- :bot, :chat_id, :talker, :user
      attr_reader :preferences

      # 'initialize' is in base
      # 'show' is in basesdasdasd
      # 'back' is in base

      private

      def before_show(*args)
        @user = DB.create_user(tg_user: user)
        @preferences = Actions::Users::Preferences.new(bot: bot, user: user)
      end

      def after_show(*args)
        preferences.show
      end

      def message_text
        I18n.t('actions.users.registration.welcome') % { name: user.first_name }
      end
    end
  end
end
