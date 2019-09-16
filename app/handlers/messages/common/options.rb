# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      class Options < Base
        attr_reader :bot, :chat_id, :user, :option

        def initialize(bot:, chat_id:, user:)
          @bot = bot
          @chat_id = chat_id
          @user = user
          @option = Actions::Users::Option.new(bot: bot, user: user)
        end

        def method_missing(method_name, *args, &block)
          splitted_method = method_name.to_s.split('_')
          action = splitted_method.first
          option_name = splitted_method[1..-1].join('_')

          case action
          when 'back'
            back
          when 'setup'
            Services::OptionSetupService.new(bot: bot, user: user).perform(option_name)
          end
        end

        def back
          option.back
        end
      end
    end
  end
end
