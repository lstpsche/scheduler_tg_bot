# frozen_string_literal: true

module Actions
  module Users
    class Base < Actions::Base
      include Helpers::Actions::UsersHelper
      # Helpers::Common
      # Helpers::TalkerActions
      # Helpers::MenusActions

      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base
      # 'show' is in base
      # 'back' mock is in base

      # 'before_show' mock is in base
      # 'after_show' mock is in base
      # 'message_text' mock is in base

      # 'callback' is in base
      # 'create_button' is in base
      # 'create_markup' is in base
      # 'option_button' is in base
      # 'option_name' is in base
    end
  end
end
