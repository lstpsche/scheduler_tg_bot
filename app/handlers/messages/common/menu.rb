# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      class Menu < Base
        attr_reader :bot, :chat_id

        def initialize(bot:, chat_id:, user:)
          @bot = bot
          @chat_id = chat_id
        end

        def my_schedules
          Actions::Features::MySchedules.new(bot: bot, chat_id: chat_id).show
        end

        def new_schedule
          # launch your your feature here
        end

        def preferences
          Actions::Users::Preferences.new(bot: bot, chat_id: chat_id).show_options_menu
        end
      end
    end
  end
end
