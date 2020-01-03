# frozen_string_literal: true

class RequestToWeb
  attr_reader :body, :request, :header, :uri

  def initialize(path)
    @uri = URI.parse(web_version_url + path)
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

  def web_version_url
    url = ENV['WEB_VERSION_URL']
    return url unless url[-1] == '/'

    url.slice(0...-1)
  end

  def http
    Net::HTTP.new(uri.host)
  end

  def generate_request
    @request = Net::HTTP::Post.new(uri.request_uri, header)
    @request.body = body.to_json
  end
end
