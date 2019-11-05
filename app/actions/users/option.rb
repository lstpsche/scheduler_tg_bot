# frozen_string_literal: true

module Actions
  module Users
    class Option < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :option, :response

      # 'initialize' is in base

      def show(given_option_name)
        params = {
          before: { option: given_option_name },
          markup_options: Constants.option_options
        }

        super(params)
      end

      def back
        show_preferences
      end

      private

      def before_show(args = {})
        @option = Constants.preferences_options.select { |opt| opt[:name] == args[:option] }.first
      end

      def callback(command)
        Constants.option_callback % {
          option_name: option_name(option),
          action: command
        }
      end

      def message_text
        user_option = user&.send(option_name(@option))

        user_option_text = if user_option
          "_Current state:_ " + user_option
        else
          'This setting was not set for you yet.'
        end

        "*#{option_button_text(@option)}*\n#{user_option_text}"
      end

      # 'create_button' is in base
      # 'create_markup' is in base
      # 'option_button_text' is in base
      # 'option_name' is in base
    end
  end
end
