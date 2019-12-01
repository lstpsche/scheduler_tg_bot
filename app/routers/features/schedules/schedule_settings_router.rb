# frozen_string_literal: true

module Routers
  module Features
    module Schedules
      class ScheduleSettingsRouter < Routers::Base
        # attrs from base -- :bot, :chat_id, :user

        def initialize(bot:, user:, schedule:)
          super(bot: bot)
          @user = user
          @chat_id = user.id
          @schedule = schedule
        end

        def route(command)
          option_name, action = command.split('__')
          case action
          when 'show'
            show(option_name)
          when 'setup'
            setup(option_name)
          end
        end

        def show(option_name)
          show_schedule_setting(@schedule, option_name)
        end

        def setup(option_name)
          setup_schedule_setting(@schedule, option_name)
          show_schedule_setting(@schedule, option_name)
        end
      end
    end
  end
end
