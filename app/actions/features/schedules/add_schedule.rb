# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class AddSchedule < Base
        # attrs from base -- :bot, :chat_id, :user

        def initialize(bot:, user:, **params)
          super(bot: bot, user: user)
          @no_back = params[:no_back]
          @message_text = params[:message_text]
        end

        def show
          params = {
            markup_options: []
          }

          super(params)
        end

        private

        def callback(schedule_id)
          Constant.add_schedule_callback % { schedule_id: schedule_id }
        end

        def create_markup(markup_options)
          super(markup_options) do
            back = I18n.t('actions.features.schedules.add_schedule.back') unless @no_back
            create = I18n.t('actions.features.schedules.add_schedule.create_new')

            [
              create_button(create[:button_text], create[:name]),
              (@no_back ? nil : create_button(back[:button_text], back[:name]))
            ].compact
          end
        end

        def message_text
          I18n.t('actions.features.schedules.add_schedule.header')
        end

        def option_button_text(schedule)
          schedule.name
        end

        def option_name(schedule)
          schedule.id
        end
      end
    end
  end
end
