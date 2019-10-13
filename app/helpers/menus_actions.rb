# frozen_string_literal: true

module Helpers
  module MenusActions
    ################# Registration #################################

    def launch_registration
      ::Actions::Users::Registration.new(bot: bot, tg_user: user).launch
    end

    def need_generate_otp
      ::Actions::Users::OTPGeneration.new(bot: bot, user: user).launch
    end

    def otp_generation_request
      ::Services::OTPGenerationRequest.new(user: user).send
    end

    ################# Main Menu ####################################

    def show_main_menu
      ::Actions::Features::Menu.new(bot: bot, user: user).show
    end

    def launch_new_schedule_creation
      ::Services::NewScheduleCreationService.new(bot: bot, user: user).launch
    end

    def show_my_schedules
      ::Actions::Features::Schedules::MySchedules.new(bot: bot, user: user).show
    end

    def show_preferences
      ::Actions::Users::Preferences.new(bot: bot, user: user).show
    end

    ################# My Schedules #################################

    def show_schedule(schedule_id)
      ::Actions::Features::Schedules::Schedule.new(bot: bot, user: user).show(schedule_id: schedule_id)
    end

    def call_back_my_schedules
      ::Actions::Features::Schedules::MySchedules.new(bot: bot, user: user).back
    end

    ################# Schedule #####################################

    def decorate_for_show_schedule(schedule)
      ::Helpers::Decorators::EventsDecorator.new(schedule).decorate_for_show_schedule
    end

    def expand_schedule(schedule_id)
      ::Actions::Features::Schedules::Schedule.new(bot: bot, user: user).expand(schedule_id: schedule_id)
    end

    def hide_schedule(schedule_id)
      ::Actions::Features::Schedules::Schedule.new(bot: bot, user: user).hide(schedule_id: schedule_id)
    end

    def pin_schedule
      set_replace_last_false
      ::Actions::Features::Schedules::Schedule.new(bot: bot, user: user).pin
    end

    def call_back_schedule
      set_replace_last_true
      ::Actions::Features::Schedules::Schedule.new(bot: bot, user: user).back
    end

    ################# Preferences ##################################

    def setup_all_preferences
      ::Actions::Users::Preferences.new(bot: bot, user: user).setup_all
    end

    def show_option(option_name)
      ::Actions::Users::Option.new(bot: bot, user: user).show(option_name)
    end

    ################# Options ######################################

    def setup_option(option_name)
      ::Services::OptionSetupService.new(bot: bot, user: user).perform(option_name)
    end

    def call_back_option
      ::Actions::Users::Option.new(bot: bot, user: user).back
    end
  end
end
