# frozen_string_literal: true

module Decorators
  module Preferences
    class Preferences < Base
      # 'initialize' is in base
      # 'decoration_parts' is in base

      private

      def header
        I18n.t('layouts.menus.preferences.header')
      end
    end
  end
end
