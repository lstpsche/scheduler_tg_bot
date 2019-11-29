# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class ExpandedSchedule < Actions::Features::Schedules::Schedule
        # attrs from parent -- :bot, :chat_id, :user, :params

        # 'initialize' is in base

        # 'show' is in parent
        # 'back' is in parent

        private

        def markup_options
          Constant.in_schedule_options
        end

        def message_text
          Decorators::MenuDecorator.decorate(
            { menu: 'expanded_schedule', resource: @schedule },
            @schedule.decorated.decorated_events
          )
        end
      end
    end
  end
end
