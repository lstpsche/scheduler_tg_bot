# frozen_string_literal: true

module Actions
  module Features
    class MySchedules < Base
      attr_reader :bot, :chat_id, :talker, :user

      def initialize(bot:, chat_id:)
        @bot = bot
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)
        @talker = Talker.new(bot: bot, user: user)
      end

      def show
        my_schedules_kb = []
        user.schedules.each do |schedule|
          my_schedules_kb << create_button(schedule.name, schedule.id)
        end
        back_text = I18n.t('actions.features.my_schedules.back')
        my_schedules_kb << create_button(back_text, 'back')

        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: my_schedules_kb)

        talker.send_or_edit_message(user: user, message_id: user.last_message_id,
                                    text: I18n.t('actions.features.my_schedules.header'), chat_id: chat_id,
                                    markup: markup)
        user.update(replace_last_message: true)
      end

      def back
        user.update(replace_last_message: true)
        Handlers::Messages::Common::Base.new(bot: bot, chat_id: chat_id, user: user).main_menu
      end

      private

      def create_button(text, callback)
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: text,
          callback_data: schedule_button_callback_data(callback)
        )
      end

      def schedule_button_callback_data(schedule_id)
        Constants.my_schedules_callback % {
          command: schedule_id,
          return_to: nil
        }
      end
    end
  end
end
