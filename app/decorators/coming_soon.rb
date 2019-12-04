# frozen_string_literal: true

module Decorators
  class ComingSoon < Base
    # 'initialize' is in base

    def decoration_parts
      [@text]
    end
  end
end
