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
          my_schedules_kb << Telegram::Bot::Types::InlineKeyboardButton.new(
            text: schedule.name,
            callback_data: schedule_button_callback_data(schedule)
          )
        end
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: my_schedules_kb)

        talker.send_or_edit_message(user: user, message_id: user.last_message_id,
                                    text: I18n.t('actions.features.my_schedules.header'), chat_id: chat_id,
                                    markup: markup, parse_mode: 'markdown')
        user.update(replace_last_message: false)
      end

      private

      def schedule_button_callback_data(schedule)
        Constants.my_schedules_callback % {
          id: schedule.id,
          return_to: nil
        }
      end
    end
  end
end
