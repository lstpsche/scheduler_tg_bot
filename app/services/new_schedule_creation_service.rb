# frozen_string_literal: true

module Services
  class NewScheduleCreationService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :schedule, :params, :errors, :back
    alias :back? :back

    # 'initialize' is in base

    def launch
      set_schedule_name_add_info

      unless back?
        create_assign_schedule
        ScheduleFillService.new(bot: bot, user: user, schedule: schedule).launch
        show_schedule_successfully_created
      end

      show_main_menu
    end

    private

    def set_schedule_name_add_info
      show_set_schedule_name_add_info
      get_parse_to_params_valid_response
    end

    def get_parse_to_params_valid_response
      loop do
        @errors = []
        raw_schedule_info = get_response_of_type('message').text.strip.gsub('—', '--')

        return @back = true if raw_schedule_info == '/back'

        parse_to_params_schedule_name(raw_schedule_info)

        @errors.empty? ? break : handle_errors
        # TODO: add here rescue for errors
      end
    end

    def parse_to_params_schedule_name(raw_schedule_info)
      parsed_info = parse_schedule_name(raw_schedule_info)
      return if parsed_info.nil?

      @params = { name: parsed_info[1]&.strip, additional_info: parsed_info[2]&.strip }
    end

    def parse_schedule_name(raw_response)
      raw_response.match(Constants.set_schedule_name_full_layout) ||
        raw_response.match(Constants.set_schedule_name_layout_without_add_info) ||
        (@errors << 'Input is invalid.'; return nil)
    end

    def create_assign_schedule
      @schedule = DB.create_schedule(
        name: params[:name],
        additional_info: params[:additional_info]
      )
      user.schedules << schedule
    end

    def handle_errors
      show_set_schedule_name_error(errors.first)
      @params = []
    end
  end
end
