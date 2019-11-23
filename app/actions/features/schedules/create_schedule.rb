# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class CreateSchedule < Actions::Features::Schedules::Base
        # attrs from base -- :bot, :chat_id, :user, :params

        # 'initialize' is in base
        # 'show' is in base

        private

        def before_show
          user.create_auth_token
        end

        def create_markup
          super do
            [
              go_to_web_button,
              back_button
            ]
          end
        end

        def message_text
          I18n.t('actions.features.schedules.create_schedule.header')
        end

        def callback
          Constant.create_schedule_callback
        end

        def go_to_web_button
          go_to_web = I18n.t('actions.features.schedules.create_schedule.go_to_web')
          Button.new(button_args(go_to_web)).inline_url(generate_url_to_schedule_creation)
        end

        def back_button
          back = I18n.t('actions.features.schedules.create_schedule.back')
          Button.new(button_args(back)).inline
        end

        def generate_url_to_schedule_creation
          link = ENV['WEB_VERSION_URL'] + I18n.t('web_version_links.new_schedule') + '?'

          add_user_params_to_link(link)
        end

        def add_user_params_to_link(raw_link)
          user_auth_params.inject(raw_link) do |link, (key, value)|
            link + "#{key}=#{value}&"
          end
        end

        def user_auth_params
          {
            user_id: user.id,
            user_token: user.authentication_token
          }
        end
      end
    end
  end
end
