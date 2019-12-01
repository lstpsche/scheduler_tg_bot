# frozen_string_literal: true

module Decorators
  module Preferences
    class Option < Base
      def initialize(context, text)
        super
        @option = context[:resource]
      end

      def decoration_parts
        [header, '', option_name, @text]
      end

      private

      def header
        I18n.t('layouts.menus.option.header')
      end

      def option_name
        I18n.t('layouts.menus.option.option_name',
          option_name: @option[:button_text]
        )
      end
    end
  end
end
