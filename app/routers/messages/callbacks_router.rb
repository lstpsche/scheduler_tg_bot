# frozen_string_literal: true

module Routers
  module Messages
    class CallbacksRouter < Routers::Messages::Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :params, :tapped_message

      HANDLERS = {
        'add_schedule' => Handlers::Callbacks::Schedules::AddSchedule,
        'coming_soon' => Handlers::Callbacks::ComingSoon,
        'create_schedule' => Handlers::Callbacks::Schedules::CreateSchedule,
        'menu' => Handlers::Callbacks::Menu,
        'options' => Handlers::Callbacks::Preferences::Option,
        'preferences' => Handlers::Callbacks::Preferences::Preferences,
        'schedule' => Handlers::Callbacks::Schedules::Schedule,
        'schedule_setting' => Handlers::Callbacks::Schedules::ScheduleSetting,
        'schedule_settings' => Handlers::Callbacks::Schedules::ScheduleSettings,
        'schedules' => Handlers::Callbacks::Schedules::AllSchedules
      }.freeze

      def initialize(bot:)
        super
        @params = {}
      end

      def route(callback)
        init_vars(callback)
        update_language_code(user.language_code)

        update_user_tapped_message
        call_handler
      end

      private

      def call_handler
        HANDLERS[params[:handler_class]].new(bot: bot, user: user).handle(params[:command])
      end

      def init_vars(callback)
        @chat_id = callback.from.id
        @tapped_message = callback.message
        @user = get_user(chat_id: chat_id)
        parse_callback(callback.data)
      end

      def parse_callback(command)
        # /^(\w+)-(\w+)$/
        parsed_command = command.match(Constant.context_command_regex)

        params[:handler_class] = parsed_command[1]
        params[:command] = parsed_command[2]
      end

      def update_user_tapped_message
        user.update(tapped_message: tapped_message)
      end
    end
  end
end
