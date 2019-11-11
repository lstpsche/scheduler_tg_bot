# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class Schedule < Base
        # attrs from base -- :bot, :chat_id, :user, :params

        # 'initialize' is in base

        # at Schedule
        def show(schedule_id:)
          find_schedule_by(id: schedule_id)

          @params = Params.new(
            markup_options: markup_options
          )

          super()
        end

        def pin
          edit_message_reply_markup(message_id: user.tapped_message_id)
          reset_user_tapped_message
          back
        end

        def back
          show_all_schedules
        end

        private

        def find_schedule_by(id:)
          @schedule = ::Schedule.find_by(id: id)
        end

        def schedule_callback(args)
          Constant.schedule_callback % {
            schedule_id: schedule.id,
            action: args[:name]
          }
        end

        def create_button_for_kb(option)
          super do |button|
            button.update(callback: schedule_callback(option))
          end
        end

        # 'create_button' is in base
      end
    end
  end
end
