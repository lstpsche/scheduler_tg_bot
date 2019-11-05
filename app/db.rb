# frozen_string_literal: true

class DB
  class << self
    def create_user(args)
      tg_user = args.fetch(:tg_user, nil)
      return false unless tg_user || args.fetch(:id, nil)

      User.create(
        id: tg_user.id,
        first_name: tg_user&.first_name || args.fetch(:first_name, ''),
        last_name: tg_user&.last_name || args.fetch(:last_name, ''),
        username: tg_user&.username || args.fetch(:username, ''),
        language_code: tg_user&.language_code || args.fetch(:language_code, 'en')
      )
    end

    def create_schedule(args)
      Schedule.create(
        name: args[:name],
        additional_info: args.fetch(:additional_info, '')
      )
    end

    def create_event(args)
      Event.create(
        weekday: args[:weekday],
        time: args[:time],
        info: args[:info],
        additional_info: args.fetch(:additional_info, ''),
        schedule_id: args.fetch(:schedule_id, '')
      )
    end
  end
end
