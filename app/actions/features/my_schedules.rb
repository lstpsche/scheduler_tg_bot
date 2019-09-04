# frozen_string_literal: true

module Actions
  module Features
    class MySchedules < Base
      attr_reader :bot, :chat_id, :talker, :user

      def initialize(bot:)
        @bot = bot
        @talker = Talker.new(bot: bot)
      end

      def show(chat_id:)
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)

        my_schedules_kb = []
        user.schedules.each do |schedule|
          my_schedules_kb << Telegram::Bot::Types::InlineKeyboardButton.new(
            text: schedule.name,
            callback_data: Constants.my_schedules_callback % {
              id: schedule.id,
              return_to: nil
            }
          )
        end
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: my_schedules_kb)

        talker.send_message(text: I18n.t('actions.features.my_schedules.header'), chat_id: chat_id, markup: markup)
      end
    end
  end
end
