# frozen_string_literal: true

class RequestToWeb
  attr_reader :uri, :header, :body

  def initialize
    @uri = URI.parse(ENV['WEB_OTP_GEN_LINK'])
    @header = { 'Content-Type': 'application/json',
                'Accept': 'applications/json' }
    @body = {}
  end

  def header=(value)
    return unless value.is_a?(Hash)

    header.merge(value)
  end

  def body=(value)
    return unless value.is_a?(Hash)

    body.merge(value)
  end

  def send
    http.request(request)
  end

  private

  def http
    Net::HTTP.new(uri.host, uri.port)
  end

  def request
    Net::HTTP::Post.new(uri.request_uri, request_header)
  end
end
