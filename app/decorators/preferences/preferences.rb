# frozen_string_literal: true

module Decorators
  module Preferences
    class Preferences < Base
      # 'initialize' is in base

      def decoration_parts
        [header, '', @text]
      end

      private

      def header
        I18n.t('layouts.menus.preferences.header')
      end
    end
  end
end
