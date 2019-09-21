# frozen_string_literal: true

module Services
  class ScheduleFillService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :schedule, :errors, :finish, :params, :weekday
    alias :finish? :finish

    def initialize(bot:, user:, schedule:)
      super(bot: bot, user: user) do
        @schedule = schedule
        @params = []
      end
    end

    def launch
      Constants.translated_weekdays.each do |weekday|
        @weekday = weekday
        @params = []
        fill_weekday
        break if finish?
      end
    end

    private

    def message_text(weekday)
      I18n.t('services.schedule_fill.enter_events') % { weekday: weekday }
    end

    def fill_weekday
      send_message(text: message_text(weekday))

      get_parse_valid_response
      return if finish?

      params.each { |param| create_assign_event(param) }
    end

    def get_parse_valid_response
      loop do
        @errors = []
        day_events = get_response_of_type('message').text.strip.split("\n")

        return if day_events.first == '/skip'
        return @finish = true if day_events.first == '/finish'

        parse_validate(day_events) || handle_errors
        errors.empty? ? break : next
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
          parse_validate(day_event)
        end
      elsif events.is_a?(String)
        params << {}
        parse_validate_day_event(events)
      end
    rescue => error
      errors << error.capitalize
      return false
    end

    def parse_validate_day_event(day_event)
      parsed = parse_day_events(day_event)
      params.last[:time] = parsed[1]
      params.last[:info] = parsed[2]
      params.last[:additional_info] = parsed[3]

      validate_time(params.last[:time])
      true
    end

    def parse_day_events(day_event)
      day_event.match(Constants.day_event_full_layout) ||
        day_event.match(Constants.day_event_layout_without_add_info) ||
        raise('Input is invalid.')
    end

    def handle_errors
      message_text = I18n.t('services.schedule_fill.input_invalid') % { error: errors.first }
      send_message(text: message_text)
      params.delete_if { |key, _v| key != :weekday }
    end

    def validate_time(time)
      Time.parse(time)
      true
    end
  end
end
