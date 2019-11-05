# frozen_string_literal: true

module Helpers
  module Common
    private

    def get_user(user = nil, chat_id: nil, fallback_user: nil)
      @user || user || User.find_by(id: chat_id) || fallback_user
    end

    def message_data_from(message)
      case message
      when Telegram::Bot::Types::Message
        return message.text
      when Telegram::Bot::Types::CallbackQuery
        return message.data
      end
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

    def set_replace_last_true
      user&.update(replace_last_message: true)
    end

    def set_replace_last_false
      user&.update(replace_last_message: false)
    end

    def user_registered?(id:)
      User.registered?(id: chat_id)
    end
  end
end
