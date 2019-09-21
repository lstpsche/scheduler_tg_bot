# frozen_string_literal: true

module Services
  class NewScheduleCreationService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :schedule, :schedule_name

    # 'initialize' is in base

    def launch
      set_schedule_name
      create_assign_schedule
      ScheduleFillService.new(bot: bot, user: user, schedule: schedule).launch
      # TODO: show "Schedule created"
    end

    private

    def set_schedule_name
      message_text = I18n.t('services.new_schedule_creation.set_schedule_name')
      send_message(text: message_text)

      @schedule_name = get_response_of_type('message').text
    end

    def create_assign_schedule
      @schedule = DB.create_schedule(name: schedule_name)
      user.schedules << schedule
    end
  end
end
