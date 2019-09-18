# frozen_string_literal: true

module Actions
  module Features
    class Schedule < Base
      # attrs from base -- :bot, :chat_id, :talker, :user
      attr_reader :schedule, :expand
      alias :expand? :expand

      # 'initialize' is in base

      def show(schedule_id:)
        @schedule = ::Schedule.find_by(id: schedule_id)
        @expand = false

        super()
      end

      def expand(schedule_id:)
        @schedule = ::Schedule.find_by(id: schedule_id)
        @expand = true

        # TODO: rewrite this somehow, I don't like it
        Base.instance_method(:show).bind(self).call
      end

      alias :hide :show

      def pin
        edit_message_reply_markup(message_id: user.last_message_id)
        back
      end

      def back
        show_my_schedules
      end

      private

      def callback(command)
        Constants.schedule_callback % {
          command: "#{schedule.id}_#{command}",
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
        stripped_add_info = add_info&.strip
        info = stripped_add_info.empty? ? nil : add_info
      end
    end
  end
end
