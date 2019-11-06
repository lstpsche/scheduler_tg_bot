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
        params = {
          markup_options: []
        }

        super(params)
      end

      alias_method :launch, :show

      private

      def before_show(*)
        @user = DB.create_user(tg_user: tg_user)
      end

      def after_show(*)
        setup_all_preferences
        show_main_menu unless need_generate_otp
      end

      def message_text
        I18n.t('actions.users.registration.welcome', name: user.first_name)
      end
    end
  end
end
