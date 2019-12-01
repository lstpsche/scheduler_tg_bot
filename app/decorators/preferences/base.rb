# frozen_string_literal: true

module Decorators
  module Preferences
    class Base < Decorators::Base
      # 'initialize' is in base

      def decoration_parts
        [header, '', @text]
      end
    end
  end
end
