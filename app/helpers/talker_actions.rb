# frozen_string_literal: true

module Helpers
  module TalkerActions
    private

    #################### Setups ####################################

    def talker(bot = @bot, chat_id = @chat_id, _user = @user)
      Talker.new(bot: bot, chat_id: chat_id, user: get_user(chat_id: chat_id))
    end

    ############## Sending--Editing--Getting #######################

    def receive_message
      talker.receive_message
    end

    def receive_response
      # THIS RESPONSE CAN BE FROM ANOTHER PERSON
      # SHOULD TEST IT AND MAYBE ADD CHECKER, IF RESPONSE IS FROM NEEDED USER
      @response = receive_message

      message_data_from(@response)
    end

    # type should be 'message' or 'callback_query'
    def receive_response_of_type(type)
      type = type.split('_').map(&:capitalize).join

      loop do
        response = receive_message
        return message_data_from(response) if response.class.name.demodulize == type
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

    def send_or_edit_message(message_id: nil, text: nil, markup: nil)
      talker.send_or_edit_message(message_id: message_id, text: text, markup: markup)
    end

    def setup_successfull
      send_message(
        text: I18n.t('actions.users.preferences.setup_successful'),
        markup: 'remove'
      )
    end

    def show_successfully_setup
      send_message(
        text: I18n.t('actions.users.options.setup_successful'),
        markup: 'remove'
      )
    end

    # TODO: move this method to UserOptionSetupService
    def send_option_message(option_name, user, markup = nil)
      message_text = I18n.t("actions.users.options.#{option_name}.text")
      send_or_edit_message(
        message_id: user.last_message_id, text: message_text,
        markup: markup
      )
    end

    #################### Errors ####################################

    def show_bad_input
      talker.show_bad_input
    end

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

    ##################### Other ####################################

    def show_help
      talker.show_help
    end
  end
end
