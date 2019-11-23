# frozen_string_literal: true

module Helpers
  module Menus
    module Registration
      private

      def register_user
        @user = DB.create_user(tg_user: @user)
        set_first_start_false
      end
    end
  end
end
