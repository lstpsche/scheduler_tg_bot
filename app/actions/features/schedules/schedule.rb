# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class Schedule < Base
        # attrs from base -- :bot, :chat_id, :user
        attr_reader :schedule, :expand
        alias_method :expand?, :expand

        # 'initialize' is in base

        def show
          markup_options = expand? ? Constant.in_schedule_options : Constant.schedule_options

          params = {
            markup_options: markup_options
          }

          super(params)
        end

        def show_short(schedule_id:)
          find_schedule_by(id: schedule_id)
          @expand = false

          show
        end

        def show_expanded(schedule_id:)
          find_schedule_by(id: schedule_id)
          @expand = true

          show
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

        def callback(command)
          Constant.schedule_callback % {
            schedule_id: schedule.id,
            action: command
          }
        end

        def message_text
          if expand?
            schedule.decorated.view
          else
            I18n.t('layouts.schedule.title',
                   schedule_name: schedule.name,
                   schedule_id: schedule.id,
                   schedule_additional_info: schedule_additional_info(schedule)
                  )
          end
        end

        def schedule_additional_info(schedule)
          add_info = schedule.additional_info
          stripped_add_info = add_info&.strip
          stripped_add_info.blank? ? nil : add_info
        end

        # 'create_button' is in base
        # 'option_button_text' is in base
        # 'option_name' is in base
      end
    end
  end
end
