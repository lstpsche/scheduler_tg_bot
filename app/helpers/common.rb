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
  end
end
