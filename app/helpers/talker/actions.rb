# frozen_string_literal: true

module Helpers
  module Talker
    module Actions
      include Helpers::Talker::CommonActions
      include Helpers::Talker::Errors

      private

      #################### Setups ####################################

      def talker(bot = @bot, chat_id = @chat_id, _user = @user)
        ::Talker.new(bot: bot, chat_id: chat_id, user: get_user(chat_id: chat_id))
      end

      ############## Sending--Editing--Getting #######################

      ##################### Other ####################################

      def show_help_message
        talker.show_help_message
      end
    end
  end
end
