# frozen_string_literal: true

module Actions
  class ComingSoon < Base
    # attrs from base -- :bot, :chat_id, :user, :params

    # 'initialize' is in base

    # 'back_to' should be in the format of common methods like `show_main_menu` = `main_menu`
    def show(back_to:)
      @params = Params.new(
        markup_options: Constant.back_button,
        resource: back_to
      )

      super()
    end

    private

    def message_text
      I18n.t('common.texts.coming_soon')
    end

    def create_button_for_kb(option)
      super do |button|
        button.update(callback: option_callback(option))
      end
    end

    def option_callback(args)
      Constant.coming_soon_callback % {
        command: args[:name],
        context: params.resource
      }
    end
  end
end
