# frozen_string_literal: true

module Helpers
  module TalkerActions
    ############## Sending--Editing--Getting #######################

    def edit_message_reply_markup(message_id:, reply_markup: nil)
      Talker.edit_message_reply_markup(bot: bot, chat_id: chat_id, message_id: message_id)
    end

    ################ Common commands ###############################

    def show_help
      Talker.show_help_message(bot: bot, chat_id: user.id)
    end

    #################### Errors ####################################

    def show_no_command
      Talker.show_no_command(bot: bot, chat_id: user.id)
    end

    def show_not_understand
      Talker.show_not_understand(bot: bot, chat_id: user.id)
    end

    def show_not_registered(chat_id: nil)
      Talker.show_not_registered(bot: bot, chat_id: chat_id || user.id)
    end
  end
end
