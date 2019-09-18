# frozen_string_literal: true

module Helpers
  module MenusActions

    ################# Main Menu ####################################

    def show_main_menu
      ::Actions::Features::Menu.new(bot: bot, chat_id: chat_id).show
    end

    def show_my_schedules
      ::Actions::Features::MySchedules.new(bot: bot, chat_id: chat_id).show
    end

    def show_preferences
      ::Actions::Users::Preferences.new(bot: bot, user: user).show
    end

    ################# My Schedules #################################

    def show_schedule(schedule_id)
      ::Actions::Features::Schedule.new(bot: bot, chat_id: chat_id).show(schedule_id: schedule_id)
    end

    def call_back_my_schedules
      ::Actions::Features::MySchedules.new(bot: bot, chat_id: chat_id).back
    end

    ################# Schedule #####################################

    def expand_schedule(schedule_id)
      ::Actions::Features::Schedule.new(bot: bot, chat_id: chat_id).expand(schedule_id: schedule_id)
    end

    def hide_schedule(schedule_id)
      ::Actions::Features::Schedule.new(bot: bot, chat_id: chat_id).hide(schedule_id: schedule_id)
    end

    def pin_schedule
      set_replace_last_false
      ::Actions::Features::Schedule.new(bot: bot, chat_id: chat_id).pin
    end

    def call_back_schedule
      set_replace_last_true
      ::Actions::Features::Schedule.new(bot: bot, chat_id: chat_id).back
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
