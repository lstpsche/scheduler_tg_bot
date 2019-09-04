# frozen_string_literal: true

class Talker
  attr_reader :bot

  def initialize(bot:)
    @bot = bot
  end

  def send_message(text:, chat_id:, markup: nil, parse_mode: 'HTML')
    markup = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true) if markup == 'remove'

    bot.api.send_message(chat_id: chat_id, text: text, reply_markup: markup, parse_mode: parse_mode)
  end

  def get_message
    bot.listen { |message| return message }
  end

  def show_not_registered(chat_id:)
    send_message(text: I18n.t('errors.not_registered'), chat_id: chat_id)
  end

  def show_something_wrong(chat_id:)
    send_message(text: I18n.t('errors.something_wrong'), chat_id: chat_id)
  end

  def edit_message(chat_id:, message_id:, text:, markup: nil)
    markup = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true) if markup == 'remove'

    bot.api.edit_message_text(chat_id: chat_id, message_id: message_id, text: text, markup: markup)
  end

  # self methods (copies of usual methods mostly)

  def self.send_message(bot:, text:, chat_id:, markup: nil, parse_mode: 'HTML')
    markup = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true) if markup == 'remove'

    bot.api.send_message(chat_id: chat_id, text: text, reply_markup: markup, parse_mode: parse_mode)
  end

  def self.show_not_registered(bot:, chat_id:)
    self.send_message(bot: bot, text: I18n.t('errors.not_registered'), chat_id: chat_id)
  end

  def self.get_message(bot:)
    bot.listen { |message| return message }
  end

  def self.send_help_message(bot:, chat_id:)
    self.send_message(bot: bot, text: I18n.t('common.help'), chat_id: chat_id)
  end

  def self.send_shorten_help_message(bot:, chat_id:)
    self.send_message(bot: bot, text: I18n.t('common.shorten_help'), chat_id: chat_id)
  end

  def self.edit_message(bot:, chat_id:, message_id:, text:, markup: nil)
    markup = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true) if markup == 'remove'

    bot.api.edit_message_text(chat_id: chat_id, message_id: message_id, text: text, markup: markup)
  end
end
