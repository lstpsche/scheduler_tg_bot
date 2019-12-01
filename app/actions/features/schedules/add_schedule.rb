# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class AddSchedule < Actions::Features::Schedules::Base
        # attrs from base -- :bot, :chat_id, :user, :params

        def initialize(bot:, user:, **params)
          super(bot: bot, user: user)
          @no_back = params[:no_back]
          @message_text = params[:message_text]
        end

        # 'show' is in base

        private

        def callback
          Constant.add_schedule_callback
        end

        def create_markup
          super do
            [
              create_schedule_button,
              back_button
            ].compact
          end
        end

        def create_schedule_button
          create_schedule = I18n.t('actions.features.schedules.add_schedule.create_new')
          Button.new(button_args(create_schedule)).inline
        end

        def back_button
          return nil if @no_back

          back = I18n.t('actions.features.schedules.add_schedule.back')
          Button.new(button_args(back)).inline
        end

        def message_text
          Decorators::MenuDecorator.decorate(
            menu: 'add_schedule'
          )
        end
      end
    end
  end
end
