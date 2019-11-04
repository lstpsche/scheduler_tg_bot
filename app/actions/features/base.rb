# frozen_string_literal: true

module Actions
  module Features
    class Base < Actions::Base
      # Helpers::Common
      # Helpers::TalkerActions
      # Helpers::MenusActions

      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base
      # 'show' is in base
      # 'back' is in base

      def show(params)
        super(params)
        set_replace_last_true
      end

      # 'before_show' mock is in base
      # 'after_show' mock is in base

      # 'callback' is in base
      # 'create_button' is in base
      # 'create_markup' is in base
      # 'option_button' is in base
      # 'option_name' is in base
    end
  end
end
