# frozen_string_literal: true

class DB
  class << self
    def create_user(args)
      tg_user = args.fetch(:tg_user, nil)
      return false unless tg_user

      User.create(id: tg_user.id,
                  first_name: tg_user&.first_name, last_name: tg_user&.last_name,
                  username: tg_user&.username, language_code: tg_user&.language_code
                 )
    end
  end
end
