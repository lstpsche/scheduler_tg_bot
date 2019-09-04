# frozen_string_literal: true

module Actions
  module Features
    class Schedule < Base
      attr_reader :bot, :chat_id, :talker, :user

      def initialize(bot:)
        @bot = bot
        @talker = Talker.new(bot: bot)
      end

      def show(chat_id:, schedule_id:)
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)
        schedule = Schedule.find_by(id: schedule_id)

        schedule_options_kb = []
        Constants.schedule_options.each do |option_name|
          schedule_options_kb << Telegram::Bot::Types::InlineKeyboardButton.new(
            text: option_name,
            callback_data: Constants.schedule_callback % {
              option: option_name,
              return_to: nil
            }
          )
        end
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: schedule_options_kb)
        text = "**#{schedule.name}**" + "\n" + schedule_additional_info(schedule)

        talker.send_message(text: text, chat_id: chat_id, markup: markup)
      end

      private

      def schedule_additional_info(schedule)
        add_info = schedule.additional_info
        info = add_info.nil? ? nil : (add_info.strip.empty? ? nil : add_info)
      end
    end
  end
end
