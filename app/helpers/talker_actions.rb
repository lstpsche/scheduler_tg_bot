# frozen_string_literal: true

module Helpers
  module TalkerActions
    # TODO: think about removing those checks and simply call methods
    # maybe it will be the same because talker var creates each time in other classes

    ############## Sending--Editing--Getting #######################

    def edit_message_reply_markup(message_id:, reply_markup: nil)
      if talker
        talker.edit_message_reply_markup(chat_id: chat_id, message_id: message_id)
      else
        Talker.edit_message_reply_markup(bot: bot, chat_id: chat_id, message_id: message_id)
      end
    end

    ################ Common commands ###############################

    def show_help
      talker ? talker.show_help_message : Talker.show_help_message(bot: bot, chat_id: user.id)
    end

    #################### Errors ####################################

    def show_no_command
      talker ? talker.show_no_command : Talker.show_no_command(bot: bot, chat_id: user.id)
    end

    def show_not_understand
      talker ? talker.show_not_understand : Talker.show_not_understand(bot: bot, chat_id: user.id)
    end

    def show_not_registered(chat_id: nil)
      talker ? talker.show_not_registered : Talker.show_not_registered(bot: bot, chat_id: chat_id || user.id)
    end
  end
end
