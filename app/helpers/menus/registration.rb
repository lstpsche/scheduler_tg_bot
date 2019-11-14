# frozen_string_literal: true

module Helpers
  module Menus
    module Registration
      private

      def launch_registration
        ::Actions::Users::Registration.new(bot: bot, tg_user: user).launch
      end

      def show_otp_generation_question
        ::Actions::Users::OTPGeneration.new(bot: bot, user: user).show
      end

      def generate_otp
        ::Services::OTPGenerationRequest.new(user: user).send
      end
    end
  end
end
