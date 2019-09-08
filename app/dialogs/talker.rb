# frozen_string_literal: true

class Talker
  attr_reader :bot, :user

  def initialize(bot:, user: nil)
    @bot = bot
    @user = user
  end

  # not-self methods should just call self methods. It's easier to maintain such code
  # (except get_message)

  def edit_message(message_id:, text: nil, chat_id:, markup: nil, parse_mode: 'HTML')
    text && bot.api.edit_message_text(chat_id: chat_id, message_id: message_id, text: text, parse_mode: parse_mode)
    markup && bot.api.edit_message_reply_markup(chat_id: chat_id, message_id: message_id, reply_markup: markup)
  end

  def get_message
    bot.listen { |message| return message }
  end

  def send_help_message(chat_id:)
    send_message(text: I18n.t('common.help'), chat_id: chat_id)
  end

  def send_message(text:, chat_id:, markup: nil, parse_mode: 'HTML')
    markup = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true) if markup == 'remove'

    msg = bot.api.send_message(chat_id: chat_id, text: text, reply_markup: markup, parse_mode: parse_mode)
    user&.update(last_message: msg)
  end

  def send_shorten_help_message(chat_id:)
    send_message(text: I18n.t('common.shorten_help'), chat_id: chat_id)
  end

  def show_not_registered(chat_id:)
    send_message(text: I18n.t('errors.not_registered'), chat_id: chat_id)
  end

  def show_something_wrong(chat_id:)
    send_message(text: I18n.t('errors.something_wrong'), chat_id: chat_id)
  end

  # self methods (copies of usual methods mostly)
  class << self
    def edit_message(bot:, message_id:, text:, chat_id:, markup: nil, parse_mode: 'HTML')
      talker(bot, user(chat_id)).edit_message(chat_id: chat_id, message_id: message_id, text: text, markup: markup)
    end

    def get_message(bot:)
      talker(bot, user(chat_id)).get_message
    end

    def send_help_message(bot:, chat_id:)
      talker(bot, user(chat_id)).send_help_message(chat_id: chat_id)
    end

    def send_message(bot:, text:, chat_id:, markup: nil, parse_mode: 'HTML')
      talker(bot, user(chat_id)).send_message(chat_id: chat_id, text: text, markup: markup)
    end

    def send_shorten_help_message(bot:, chat_id:)
      talker(bot, user(chat_id)).send_shorten_help_message(chat_id: chat_id)
    end

    def show_not_registered(bot:, chat_id:)
      talker(bot, user(chat_id)).show_not_registered(chat_id: chat_id)
    end

    def show_something_wrong(bot:, chat_id:)
      talker(bot, user(chat_id)).show_something_wrong(chat_id: chat_id)
    end

    def talker(bot, user)
      Talker.new(bot: bot, user: user)
    end

    def user(id)
      User.find_by(id: id)
    end
  end
end
