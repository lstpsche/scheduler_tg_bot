# frozen_string_literal: true

module Actions
  module Features
    class Schedule < Base
      attr_reader :bot, :chat_id, :talker

      def initialize(bot:, chat_id:, user:)
        @bot = bot
        @chat_id = chat_id
        @talker = Talker.new(bot: bot)
      end

      def show(schedule_id:)
        schedule = ::Schedule.find_by(id: schedule_id)

        markup = create_inline_markup_with(Constants.schedule_options, schedule)
        text = "*#{schedule.name}*\n#{schedule_additional_info(schedule)}"

        talker.send_message(text: text, chat_id: chat_id, markup: markup, parse_mode: 'markdown')
      end

      def expand(schedule_id: schedule_id)
        schedule = ::Schedule.find_by(id: schedule_id)

        markup = create_inline_markup_with(Constants.in_schedule_options, schedule)
        text = ::Helpers::Decorators::EventsDecorator.new(schedule).decorate_for_show_schedule

        talker.send_message(text: text, chat_id: chat_id, markup: markup, parse_mode: 'markdown')
      end

      alias :hide :show

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
