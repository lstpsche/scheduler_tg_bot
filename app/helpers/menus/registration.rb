# frozen_string_literal: true

module Helpers
  module Menus
    module Registration
      private

      def register_user
        @user = DB.create_user(tg_user: @user)
        set_first_start_false
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
