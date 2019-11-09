# frozen_string_literal: true

module Helpers
  module Menus
    module Registration
      private

      def launch_registration
        ::Actions::Users::Registration.new(bot: bot, tg_user: user).launch
      end

      def need_generate_otp
        ::Actions::Users::OTPGeneration.new(bot: bot, user: user).launch
      end

      def otp_generation_request
        ::Services::OTPGenerationRequest.new(user: user).send
      end
    end
  end
end
