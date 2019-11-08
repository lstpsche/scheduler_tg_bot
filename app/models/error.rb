# frozen_string_literal: true

class Error
  attr_reader :code, :message

  def initialize(code: nil, message: nil)
    @code = code
    @message = message
  end

  def full
    "#{code}: #{message}"
  end

  def type
    return nil unless TYPES.include?(short_code)

    TYPES[short_code]
  end

  private

  TYPES = {
    4 => 'client',
    5 => 'server'
  }.freeze

  def short_code
    code / 100
  end
end
