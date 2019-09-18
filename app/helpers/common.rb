# frozen_string_literal: true

module Helpers
  module Common
    def save_validate_user
      if user.save
        yield
      else
        talker.show_something_wrong
        # TODO: handle this
      end
    end

    def set_replace_last_true
      user.update(replace_last_message: true)
    end

    def set_replace_last_false
      user.update(replace_last_message: false)
    end

    def get_user(user = nil, chat_id: nil, fallback_user: nil)
      @user ||= user || User.find_by(id: chat_id) || fallback_user
    end

    def user_registered?(id:)
      get_user(chat_id: id) ? true : false
    end

    def user_not_registered?(id:)
      !user_registered?(id: id)
    end
  end
end
