# frozen_string_literal: true

ROUTERS = {
  'Message' => Routers::TextCommandsRouter,
  'CallbackQuery' => Routers::CallbacksRouter
}.freeze

class Bot
  attr_reader :bot, :token

  def initialize(token)
    @token = token
  end

  def launch
    Telegram::Bot::Client.run(token) do |bot|
      @bot = bot
      talker = Talker.new(bot: bot)

      loop do
        message = talker.get_message
        binding.pry
        parse_message_type(message)
      rescue => error
        # TODO: parse error and give error message basing on it
        Talker.new(bot: bot, chat_id: message.from.id).show_bad_input
      end
    end
  end

  private

  def parse_message_type(message)
    # maybe handle errors which are returned from this route()
    # errors are returned only from text commands now
    ROUTERS[message.class.name.demodulize].new(bot: bot).route(message)
  end
end
