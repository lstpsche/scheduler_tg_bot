# frozen_string_literal: true

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
    parse_message
  end

  def handle_error(error)
    # binding.pry
    raise error unless ENV['ENV'] == 'production'

    errors_handler.handle(error: error)
  end

  def parse_message
    # maybe handle errors which are returned from this route()
    # errors are returned only from text commands now
    Routers::Messages::MessagesRouter.new(bot: bot).parse_message(@message)
  end

  def errors_handler
    @errors_handler ||= Handlers::ErrorsHandler.new(bot: bot, chat_id: @message.from.id)
  end
end
