# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class CreateSchedule < Base
        # attrs from base -- :bot, :chat_id, :user

        # 'initialize' is in base

        def show
          params = {
            markup_options: []
          }

          super(params)
        end

        private

        def before_show(*)
          user.update(authentication_token: generate_auth_token) unless user.authentication_token.present?
        end

        def generate_auth_token
          SecureRandom.urlsafe_base64
        end

        def create_button_with_url(text)
          Telegram::Bot::Types::InlineKeyboardButton.new(
            text: text,
            url: generate_link_to_schedule_creation
          )
        end

        def create_markup(markup_options)
          link_button_text = I18n.t('actions.features.schedules.create_schedule.button_text')
          super(markup_options) do
            create_button_with_url(link_button_text)
          end
        end

        def message_text
          I18n.t('actions.features.schedules.create_schedule.header')
        end

        def user_auth_params
          {
            user_id: user.id,
            user_token: user.authentication_token
          }
        end

        def generate_link_to_schedule_creation
          link = ENV['WEB_VERSION_URL'] + I18n.t('web_version_links.new_schedule') + '?'

          user_auth_params.each do |key, value|
            link += "#{key}=#{value}&"
          end

          link.slice!(-1)
          link
        end
      end
    end
  end
end
