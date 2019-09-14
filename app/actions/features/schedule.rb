# frozen_string_literal: true

module Actions
  module Features
    class Schedule < Base
      attr_reader :schedule, :expand
      alias :expand? :expand

      def show(schedule_id:)
        @schedule = ::Schedule.find_by(id: schedule_id)
        @expand = false

        super()
      end

      def expand(schedule_id:)
        @schedule = ::Schedule.find_by(id: schedule_id)
        @expand = true

        Base.instance_method(:show).bind(self).call
      end

      alias :hide :show

      def pin
        talker.edit_message_reply_markup(chat_id: chat_id, message_id: user.last_message_id)
        back
      end

      def back
        Handlers::Messages::Common::Menu.new(bot: bot, chat_id: chat_id, user: user).my_schedules
      end

      private

      def callback(command)
        Constants.schedule_callback % {
          command: "#{schedule.id}__#{command}",
          return_to: nil
        }
      end

      # create_button is in base

      def create_markup
        super(expand? ? Constants.in_schedule_options : Constants.schedule_options)
      end

      def message_text
        if expand?
          ::Helpers::Decorators::EventsDecorator.new(schedule).decorate_for_show_schedule
        else
          "*#{schedule.name}*\n#{schedule_additional_info(schedule)}"
        end
      end

      # option_button is in base
      # option_name is in base

      def schedule_additional_info(schedule)
        add_info = schedule.additional_info
        info = add_info.nil? ? nil : (add_info.strip.empty? ? nil : add_info)
      end
    end
  end
end
