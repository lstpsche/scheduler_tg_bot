# frozen_string_literal: true

module Actions
  module Features
    class Schedule < Base
      attr_reader :bot, :chat_id, :talker, :user

      def initialize(bot:, chat_id:)
        @bot = bot
        @chat_id = chat_id
        @user = User.find_by(id: chat_id)
        @talker = Talker.new(bot: bot, user: user)
      end

      def show(schedule_id:)
        schedule = ::Schedule.find_by(id: schedule_id)

        markup = create_inline_markup_with(Constants.schedule_options, schedule)
        text = "*#{schedule.name}*\n#{schedule_additional_info(schedule)}"

        talker.send_or_edit_message(message_id: user.last_message_id, text: text, chat_id: chat_id,
                                    markup: markup)
        user.update(replace_last_message: true)
      end

      def expand(schedule_id:)
        schedule = ::Schedule.find_by(id: schedule_id)

        markup = create_inline_markup_with(Constants.in_schedule_options, schedule)
        text = ::Helpers::Decorators::EventsDecorator.new(schedule).decorate_for_show_schedule

        talker.send_or_edit_message(message_id: user.last_message_id, text: text, chat_id: chat_id,
                                    markup: markup)
        user.update(replace_last_message: true)
      end

      alias :hide :show

      def pin
        talker.edit_message_reply_markup(chat_id: chat_id, message_id: user.last_message_id)
        back
      end

      def back
        Handlers::Messages::Common::Menu.new(bot: bot, chat_id: chat_id, user: user).my_schedules
      end

      private

      def create_button(schedule, option_name)
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: option_name,
          callback_data: Constants.schedule_callback % {
            schedule_id: schedule.id,
            option: option_name.downcase.split(' ').join('_'),
            return_to: nil
          }
        )
      end

      def create_inline_markup_with(options, schedule)
        kb = []
        options.each do |option_name|
          kb << create_button(schedule, option_name)
        end

        Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      end

      def schedule_additional_info(schedule)
        add_info = schedule.additional_info
        info = add_info.nil? ? nil : (add_info.strip.empty? ? nil : add_info)
      end
    end
  end
end
