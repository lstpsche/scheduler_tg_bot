# frozen_string_literal: true

module Handlers
  module Callbacks
    class Base < Handlers::Base
      # Helpers::Common
      # Helpers::Menus::Actions
      # Helpers::Talker::Actions

      # attrs from base -- :bot, :chat_id, :user
      attr_reader :talker

      def initialize(bot:, user:)
        @bot = bot
        @chat_id = user.id
        @user = user
        self.class::HANDLE_METHODS ||= {}
      end

      def handle(command)
        if handler_exists_for?(command)
          call_handler(command)
        else
          yield if block_given?
        end
      end

      private

      def handle_methods
        self.class::HANDLE_METHODS
      end

      def check_schedule_validity(schedule_id)
        @schedule = ::Schedule.find_by(id: schedule_id)

        raise Error.new(code: 500, message: 'Invalid schedule_id') unless @schedule.present?
      end

      def handler_exists_for?(command)
        handle_methods.keys.include?(command)
      end

      def call_handler(command)
        method(handle_methods[command]).call
      end
    end
  end
end
