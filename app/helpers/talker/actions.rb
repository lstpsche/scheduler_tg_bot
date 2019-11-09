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

      # TODO: move this method to UserOptionSetupService
      def send_option_message(option_name, markup = nil)
        message_text = I18n.t("actions.users.options.#{option_name}.text")
        send_message(text: message_text, markup: markup)
      end

      ##################### Other ####################################

      def show_help
        talker.show_help
      end
    end
  end
end
