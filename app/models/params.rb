# frozen_string_literal: true

class Params < Base
  attr_reader :before, :after, :markup_options, :resource

  def initialize(before: nil, after: nil, markup_options: [], resource: nil)
    @before = before
    @after = after
    @markup_options = markup_options
    @resource = resource
  end
end
