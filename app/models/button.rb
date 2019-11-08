# frozen_string_literal: true

class Button < Base
  attr_reader :text, :name, :callback_template, :callback

  def initialize(args)
    @text = args[:button_text]
    @name = args[:name]
    @callback_template = args[:callback]
  end

  def inline
    Telegram::Bot::Types::InlineKeyboardButton.new(
      text: text, callback_data: callback_data(name)
    )
  end

  def inline_url(url)
    Telegram::Bot::Types::InlineKeyboardButton.new(
      text: text,
      url: url
    )
  end

  private

  def callback_data(name)
    return name unless @callback || callback_template

    @callback || callback_template % { command: name }
  end
end
