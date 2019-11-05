# frozen_string_literal: true

module Services
  class ScheduleFillService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :schedule, :errors, :finish, :next_day, :params, :weekday
    alias :finish? :finish
    alias :next_day? :next_day

    def initialize(bot:, user:, schedule:)
      super(bot: bot, user: user) do
        @schedule = schedule
        @params = []
        @finish = false
      end
    end

    def launch
      Constants.translated_weekdays.each do |weekday|
        @weekday = weekday
        @params = []
        @next_day = false

        fill_weekday
        break if finish?
      end
    end

    private

    def message_text(weekday)
      I18n.t('services.new_schedule_creation.header') +
        I18n.t('services.new_schedule_creation.schedule_fill.enter_events') % { weekday: weekday }
    end

    def fill_weekday
      send_message(text: message_text(weekday))

      get_parse_valid_response
      return if next_day? || finish?

      params.each { |param| create_assign_event(param) }
    end

    def get_parse_valid_response
      loop do
        @errors = []
        day_events = get_response_of_type('message').strip.split("\n")

        return @next_day = true if day_events.first == '/next_day'
        return @finish = true if day_events.first == '/finish'

        parse_validate(day_events)

        errors.empty? ? break : handle_errors
      end
    end

    def create_assign_event(param)
      DB.create_event(
        weekday: weekday,
        time: param[:time],
        info: param[:info],
        additional_info: param[:additional_info],
        schedule_id: schedule.id
      )
    end

    def parse_validate(events)
      if events.is_a?(Array)
        events.each do |day_event|
          @params << {}
          parse_validate(day_event)
        end
      elsif events.is_a?(String)
        parse_validate_day_event(events)
      end
    rescue => error
      @errors << error.to_s.capitalize
      return false
    end

    def parse_validate_day_event(day_event)
      day_event.gsub!('—', '--')
      parsed = parse_day_events(day_event)
      params[-1] = {
        time: parse_validate_time(parsed[1]),
        info: parsed[2],
        additional_info: parsed[3]
      }

      true
    end

    def parse_day_events(day_event)
      day_event.match(Constants.day_event_full_layout) ||
        day_event.match(Constants.day_event_layout_without_add_info) ||
        raise('Input is invalid.')
    end

    def handle_errors
      show_new_schedule_error(errors.first)
      @params = []
    end

    def parse_validate_time(time)
      Time.parse(time).strftime('%H:%M')
    end
  end
end
