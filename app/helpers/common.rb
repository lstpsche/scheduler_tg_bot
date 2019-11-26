# frozen_string_literal: true

module Helpers
  module Common
    private

    def bot_api
      bot.api
    end

    def get_user(user = nil, chat_id: nil, fallback_user: nil)
      @user || user || User.find_by(id: chat_id) || fallback_user
    end

    def message_data_from(message)
      case message
      when Telegram::Bot::Types::Message
        message.text
      when Telegram::Bot::Types::CallbackQuery
        message.data
      end
    end

    # type should be 'message' or 'callback_query'
    def message_is_a?(type, message)
      type = type.split('_').map(&:capitalize).join

      message_type(message) == type
    end

    def message_type(message)
      message.class.name.demodulize
    end

    def reset_user_tapped_message
      user.present? && user.try(:tapped_message).present? && user.update(tapped_message: nil)
    end

    def user_option(option_name)
      # add here options from related models
      # for example:
      user.try(option_name) # || user.student_settings.try(option_name)
    end

    def user_option_text(option_name)
      option = user_option(option_name)

      if option.present?
        I18n.t('actions.users.option.user_option_text.present', option_value: option)
      else
        I18n.t('actions.users.option.user_option_text.not_present')
      end
    end

    def user_registered?(id:)
      User.registered?(id: id)
    end

    def update_language_code(code)
      @user.update(language_code: code) unless user_is_tg_user? && @user.language_code == code
    end

    def user_is_tg_user?
      @user.present? && @user.is_a?(Telegram::Bot::Types::User)
    end

    def set_first_start_false
      @user.update(global_bot_first_start: false)
    end
  end
end
