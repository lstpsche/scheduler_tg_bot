# frozen_string_literal: true

ROUTERS = {
  'Message' => Routers::Messages::TextCommandsRouter,
  'CallbackQuery' => Routers::Messages::CallbacksRouter
}.freeze

class Bot
  attr_reader :bot

  def initialize(token)
    @token = token
  end

  def launch
    Telegram::Bot::Client.run(@token) do |bot|
      @bot = bot
      @talker = Talker.new(bot: bot)

      launch_bot
    end
  end

  private

  def launch_bot
    loop do
      receive_and_parse_message
    rescue StandardError => error
      handle_error(error)
    end
  end

  def receive_and_parse_message
    @message = @talker.receive_message
    # binding.pry
    parse_message_type
  end

  def handle_error(error)
    # binding.pry
    raise error unless ENV['ENV'] == 'production'

    Services::ErrorParserService.new(bot: bot, chat_id: @message.from.id, error: error.to_s).handle_errors
  end

  def parse_message_type
    # maybe handle errors which are returned from this route()
    # errors are returned only from text commands now
    ROUTERS[@message.class.name.demodulize].new(bot: bot).route(@message)
  end
end
