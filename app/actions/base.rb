# frozen_string_literal: true

module Actions
  class Base
    include Helpers::Common
    include Helpers::Talker::Actions
    include Helpers::Menus::Actions

    attr_reader :bot, :chat_id, :user, :params

    def initialize(bot:, user:)
      @bot = bot
      @user = user
      @chat_id = user.id
      @params ||= Params.new
    end

    def show
      before_show

      send_or_edit_message(
        message_id: user.tapped_message_id,
        text: message_text, markup: create_markup
      )

      after_show
    end

    def back
      raise NotImplementedError
    end

    private

    def before_show; end

    def after_show; end

    def callback; end

    def create_markup
      options = @params.markup_options
      return nil unless options.present? || block_given?

      kb = create_buttons(options) { yield if block_given? }
      Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    end

    def create_buttons(options)
      kb = []
      options.each do |option|
        kb << create_button_for_kb(option)
      end
      kb += Array.wrap(yield) if block_given?
    end

    def create_button_for_kb(option)
      button = create_button(option)
      yield(button) if block_given?
      button.inline
    end

    def create_button(option)
      Button.new(button_args(option))
    end

    def button_args(option)
      option.merge(callback: callback)
    end

    def message_text
      raise NotImplementedError
    end
  end
end
