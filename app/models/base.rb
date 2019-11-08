# frozen_string_literal: true

class Base
  def update(args)
    args.each do |key, value|
      instance_variable_set("@#{key}", value)
    end

    self
  end
end
