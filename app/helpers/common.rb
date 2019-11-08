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
      user&.update(tapped_message: nil)
    end

    def save_validate_user
      if user.save
        yield
      else
        show_something_wrong
        # maybe parse errors and show them to user
        # (rather no)
      end
    end

    def user_option_text(option_name)
      option = user.try(option_name)

      if option.present?
        I18n.t('actions.users.option.user_option_text.present', option_value: option)
      else
        I18n.t('actions.users.option.user_option_text.not_present')
      end
    end

    def user_registered?(id:)
      User.registered?(id: id)
    end
  end
end
