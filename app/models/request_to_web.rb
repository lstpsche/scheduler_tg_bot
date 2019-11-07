# frozen_string_literal: true

class RequestToWeb
  attr_reader :body, :request, :header, :uri

  def initialize(path)
    @uri = URI.parse('http://localhost:3000' + path)
    @header = { 'Content-Type': 'application/json',
                'Accept': 'applications/json' }
    @body = {}
    generate_request
  end

  def header=(value)
    return unless value.is_a?(Hash)

    header.merge!(value)
    generate_request
  end

  def body=(value)
    return unless value.is_a?(Hash)

    body.merge!(value)
    request.body = body.to_json
  end

  def send
    http.request(request)
  end

  private

  def http
    Net::HTTP.new(uri.host, uri.port)
  end

  def generate_request
    @request = Net::HTTP::Post.new(uri.request_uri, header)
    @request.body = body.to_json
  end
end
