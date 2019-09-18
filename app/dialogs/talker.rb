# frozen_string_literal: true

class Talker
  include Helpers::Common

  attr_reader :bot, :chat_id, :user

  def initialize(bot:, chat_id: nil, user: nil)
    @bot = bot
    @chat_id = chat_id || user&.id
    @user = user || get_user(chat_id: chat_id)
  end

  # self methods should just call non-self methods. It's easier to maintain such code
  # (except get_message)

  def edit_message(message_id:, text: nil, chat_id:, markup: nil, parse_mode: 'markdown')
    text && bot.api.edit_message_text(chat_id: chat_id, message_id: message_id, text: text, parse_mode: parse_mode)
    markup && bot.api.edit_message_reply_markup(chat_id: chat_id, message_id: message_id, reply_markup: markup)
  end

  def edit_message_reply_markup(chat_id:, message_id:, reply_markup: nil)
    bot.api.edit_message_reply_markup(chat_id: chat_id, message_id: message_id, reply_markup: reply_markup)
  end

  def get_message
    bot.listen { |message| return message }
  end

  def show_help_message
    send_message(text: I18n.t('common.help'), chat_id: chat_id)
  end

  def send_message(text:, chat_id:, markup: nil, parse_mode: 'HTML')
    markup = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true) if markup == 'remove'

    msg = bot.api.send_message(chat_id: chat_id, text: text, reply_markup: markup, parse_mode: parse_mode)
    get_user(chat_id: chat_id).update(last_message: msg)
  end

  def send_or_edit_message(user: nil, message_id: nil, text: nil, chat_id:, markup: nil, parse_mode: 'markdown')
    if get_user(user, chat_id: chat_id).replace_last_message?
      edit_message(message_id: message_id, text: text, chat_id: chat_id, markup: markup, parse_mode: parse_mode)
    else
      send_message(text: text, chat_id: chat_id, markup: markup, parse_mode: parse_mode)
    end
  end

  def show_no_command
    send_message(text: I18n.t('errors.no_command'), chat_id: chat_id)
    set_replace_last_false
  end

  def show_not_registered
    send_message(text: I18n.t('errors.not_registered'), chat_id: chat_id)
    set_replace_last_false
  end

  def show_not_understand
    send_message(text: I18n.t('errors.not_understand'), chat_id: chat_id)
    set_replace_last_false
  end

  def show_something_wrong
    send_message(text: I18n.t('errors.something_wrong'), chat_id: chat_id)
    set_replace_last_false
  end

  public
  # self methods (copies of usual methods mostly)
  class << self
    def edit_message(bot:, message_id:, text:, chat_id:, markup: nil, parse_mode: 'markdown')
      talker(bot, user(chat_id)).edit_message(chat_id: chat_id, message_id: message_id, text: text, markup: markup)
    end

    def edit_message_reply_markup(bot:, chat_id:, message_id:, reply_markup: nil)
      talker(bot, user(chat_id)).edit_message_reply_markup(chat_id: chat_id, message_id: message_id,
                                                            reply_markup: reply_markup)
    end

    def get_message(bot:, chat_id:)
      talker(bot, user(chat_id)).get_message
    end

    def send_help_message(bot:, chat_id:)
      talker(bot, user(chat_id)).send_help_message
    end

    def send_message(bot:, text:, chat_id:, markup: nil, parse_mode: 'markdown')
      talker(bot, user(chat_id)).send_message(chat_id: chat_id, text: text, markup: markup)
    end

    def send_or_edit_message(bot:, user:, message_id: nil, text: nil, chat_id:, markup: nil, parse_mode: 'HTML')
      talker(bot, user).send_or_edit_message(message_id: message_id, text: text, chat_id: chat_id,
                                             markup: markup, parse_mode: parse_mode)
    end

    def send_shorten_help_message(bot:, chat_id:)
      talker(bot, user(chat_id)).send_shorten_help_message
    end

    def show_no_command(bot:, chat_id:)
      talker(bot, user(chat_id)).show_no_command
    end

    def show_not_registered(bot:, chat_id:)
      talker(bot, user(chat_id)).show_not_registered
    end

    def show_not_understand(bot:, chat_id:)
      talker(bot, user(chat_id)).show_not_understand
    end

    def show_something_wrong(bot:, chat_id:)
      talker(bot, user(chat_id)).show_something_wrong
    end

    def talker(bot, user)
      Talker.new(bot: bot, user: user)
    end

    def user(id)
      User.find_by(id: id)
    end
  end
end
