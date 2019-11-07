# frozen_string_literal: true

module Services
  class OTPGenerationRequest < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :request

    def initialize(user:)
      @user = user
    end

    def send
      prepare_request
      send_request
      true
    end

    private

    def hash_auth_token(username)
      require 'digest'
      Digest::SHA256.hexdigest(username + ENV['REQUEST_SALT'])
    end

    def generate_bot_request_auth_token
      auth_token = hash_auth_token(user.username)
      user.update(bot_request_auth_token: auth_token)

      auth_token
    end

    def prepare_request
      @request = RequestToWeb.new(I18n.t('web_version_links.otp_generation'))
      request.header = { 'Validity-Token': generate_bot_request_auth_token }
      request.body = { user: { username: user.username } }
    end

    def send_request
      request.send
    end
  end
end
