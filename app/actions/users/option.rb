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
          markup_options: Constant.option_options
        }

        super(params)
      end

      def back
        show_preferences
      end

      private

      def before_show(args = {})
        @option = Constant.preferences_options.select { |opt| opt[:name] == args[:option] }.first
      end

      def callback(command)
        Constant.option_callback % {
          option_name: option_name(option),
          action: command
        }
      end

      def message_text
        I18n.t('actions.users.option.message_text',
               button_text: option_button_text(option),
               user_option_text: user_option_text(option_name(option))
              )
      end

      # 'create_button' is in base
      # 'create_markup' is in base
      # 'option_button_text' is in base
      # 'option_name' is in base
    end
  end
end
