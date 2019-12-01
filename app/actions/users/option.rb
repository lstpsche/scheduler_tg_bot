# frozen_string_literal: true

module Actions
  module Users
    class Option < Actions::Users::Base
      # attrs from base -- :bot, :chat_id, :user, :params
      attr_reader :response

      # 'initialize' is in base

      def show(given_option_name)
        @params = Params.new(
          before: { option: given_option_name },
          markup_options: Constant.option_options
        )

        super()
      end

      def back
        show_preferences
      end

      private

      def before_show
        params.update(resource: given_option_params)
      end

      def given_option_params
        Constant.preferences_options.select { |opt| opt[:name] == params.before[:option] }.first
      end

      def message_text
        Decorators::MenuDecorator.decorate(
          { menu: 'option', resource: params.resource },
          text_to_decorate
        )
      end

      def text_to_decorate
        I18n.t('actions.users.option.message_text',
               user_option_text: user_option_text(params.resource[:name])
              )
      end

      def create_button_for_kb(option)
        super do |button|
          button.update(callback: option_callback(option))
        end
      end

      def option_callback(args)
        Constant.option_callback % {
          option_name: params.resource[:name],
          action: args[:name]
        }
      end
    end
  end
end
