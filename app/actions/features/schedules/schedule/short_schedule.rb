# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class ShortSchedule < Actions::Features::Schedules::Schedule
        # attrs from parent -- :bot, :chat_id, :user, :params

        # 'initialize' is in base

        # 'show' is in parent
        # 'back' is in parent

        private

        def markup_options
          Constant.schedule_options
        end

        def message_text
          Decorators::MenuDecorator.decorate(
            { menu: 'short_schedule', resource: @schedule }
          )
        end
      end
    end
  end
end
