# frozen_string_literal: true

module Helpers
  module TalkerActions
    #################### Setups ####################################

    def talker(bot = @bot, chat_id = @chat_id, user = @user)
      Talker.new(bot: bot, chat_id: chat_id, user: get_user(chat_id: chat_id))
    end

    ############## Sending--Editing--Getting #######################

    def get_message
      talker.get_message
    end

    # type should be 'message' or 'callback_query'
    def get_response_of_type(type)
      type = type.split('_').map(&:capitalize).join

      loop do
        response = get_message
        return response if response.class.name.demodulize == type
      end
    end

    def send_message(text:, markup: nil)
      talker.send_message(text: text, markup: markup)
    end

    def edit_message(message_id:, text:, markup: nil)
      talker.edit_message(message_id: message_id, text: text, markup: markup)
    end

    def edit_message_reply_markup(message_id:, reply_markup: nil)
      talker.edit_message_reply_markup(message_id: message_id, reply_markup: reply_markup)
    end

    def send_or_edit_message(message_id: nil, text: nil, markup: nil, parse_mode: 'markdown')
      talker.send_or_edit_message(message_id: message_id, text: text,
                                  markup: markup, parse_mode: parse_mode)
    end

    ################ Common commands ###############################

    def show_help
      talker.show_help
    end

    #################### Errors ####################################

    def show_no_command
      talker.show_no_command
    end

    def show_not_registered
      talker.show_not_registered
    end

    def show_not_understand
      talker.show_not_understand
    end

    def show_something_wrong
      talker.show_something_wrong
    end
  end
end
