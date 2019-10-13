# frozen_string_literal: true

module Services
  class OTPGenerationRequest < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :http, :request

    def initialize(user:)
      @user = user
    end

    def send
      prepare_request
      send_request
    end

    private

    def hash_auth_token(username)
      require 'digest'
      Digest::SHA256.hexdigest(username + ENV['REQUEST_SALT'])
    end

    def generate_bot_request_auth_token
      @auth_token = hash_auth_token(user.username)
      user.update(bot_request_auth_token: @auth_token)

      @auth_token
    end

    def prepare_request
      uri = URI.parse(ENV['WEB_OTP_GEN_LINK'])
      header = {
        'Content-Type': 'application/json',
        'Accept': 'applications/json',
        'Validity-Token': generate_bot_request_auth_token
      }
      body = {
        user: {
          username: user.username
        }
      }

      @http = Net::HTTP.new(uri.host, uri.port)
      @request = Net::HTTP::Post.new(uri.request_uri, header)
      @request.body = body.to_json
    end

    def send_request
      @response = http.request(request)
    end
  end
end
