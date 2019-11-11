# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class Schedule < Base
        # attrs from base -- :bot, :chat_id, :user, :params
        attr_reader :schedule, :expand
        alias_method :expand?, :expand

        # 'initialize' is in base

        # at Schedule
        def show
          @params = Params.new(
            markup_options: markup_options
          )

          super
        end

        # at ShortSchedule
        def show_short(schedule_id:)
          find_schedule_by(id: schedule_id)
          @expand = false

          show
        end

        # at ExpandedSchedule
        def show_expanded(schedule_id:)
          find_schedule_by(id: schedule_id)
          @expand = true

          show
        end

        # at Schedule
        def pin
          edit_message_reply_markup(message_id: user.tapped_message_id)
          reset_user_tapped_message
          back
        end

        # at Schedule
        def back
          show_all_schedules
        end

        private

        # at each inheritted file
        def markup_options
          expand? ? Constant.in_schedule_options : Constant.schedule_options
        end

        def find_schedule_by(id:)
          @schedule = DecoratedSchedule.find_by(id: id)
        end

        # at schedule
        def schedule_callback(args)
          Constant.schedule_callback % {
            schedule_id: schedule.id,
            action: args[:name]
          }
        end

        # at each inherited file
        def message_text
          if expand?
            schedule.decorated.view
          else
            I18n.t('layouts.schedule.title',
                   schedule_name: schedule.name,
                   schedule_id: schedule.id,
                   schedule_additional_info: schedule.additional_info
                  )
          end
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
