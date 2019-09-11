# frozen_string_literal: true

module Handlers
  module Messages
    module Common
      class Schedule < Base
        attr_reader :bot, :chat_id, :user, :schedule

        def method_missing(method_name, *args, &block)
          parsed_method_name = method_name.to_s.split('__')
          @schedule = Actions::Features::Schedule.new(bot: bot, chat_id: chat_id)

          case parsed_method_name.last
          when 'show_schedule'
            expand_schedule(parsed_method_name.first)
          when 'hide_schedule'
            hide_schedule(parsed_method_name.first)
          end
        end

        private

        def expand_schedule(schedule_id)
          schedule.expand(schedule_id: schedule_id)
        end

        def hide_schedule(schedule_id)
          schedule.hide(schedule_id: schedule_id)
        end
      end
    end
  end
end
