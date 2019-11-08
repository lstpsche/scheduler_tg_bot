# frozen_string_literal: true

module Actions
  module Users
    class Registration < Base
      # attrs from base -- :bot, :chat_id, :user, :params

      def initialize(bot:, tg_user:)
        super(bot: bot, user: DB.create_user(tg_user: tg_user))
      end

      # 'initialize' is in base

      alias_method :launch, :show

      private

      def after_show
        setup_all_preferences
        show_main_menu unless need_generate_otp
      end

      def message_text
        I18n.t('actions.users.registration.welcome', name: user.first_name)
      end
    end
  end
end
