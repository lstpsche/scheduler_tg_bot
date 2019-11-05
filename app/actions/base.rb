# frozen_string_literal: true

module Actions
  class Base
    include Helpers::Common
    include Helpers::TalkerActions
    include Helpers::MenusActions

    attr_reader :bot, :chat_id, :user

    def initialize(bot:, user:)
      @bot = bot
      @user = user
      @chat_id = user.id
    end

    def show(args = {})
      before_show(args[:before])

      send_or_edit_message(
        message_id: user.tapped_message_id,
        text: message_text, markup: create_markup(args[:markup_options])
      )

      after_show(args[:after])
    end

    def back
      raise NotImplementedError
    end

    private

    def before_show(*args); end
    def after_show(*args); end

    def callback(command)
      command
    end

    def create_button(text, callback)
      Telegram::Bot::Types::InlineKeyboardButton.new(
        text: text,
        callback_data: callback(callback)
      )
    end

    def create_markup(options = [])
      return unless !options.empty? || block_given?

      kb = []
      options.each do |option|
        kb << create_button(option_button(option), option_name(option))
      end
      kb += Array.wrap(yield) if block_given?

      Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    end

    def message_text
      raise NotImplementedError
    end

    def option_button(option)
      option[:button]
    end

    def option_name(option)
      option[:name]
    end
  end
end
