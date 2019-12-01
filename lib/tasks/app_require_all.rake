# frozen_string_literal: true

namespace :app do
  task 'require_gems' do
    require 'active_record'
    require 'dotenv/load'
    require 'i18n'
    require 'json'
    require 'net/http'
    require 'pry'
    require 'require_all'
    require 'securerandom'
    require 'telegram/bot'
    require 'time'
    require 'uri'
  end

  task 'require_files' do
    # ORDER MATTERS

    ## helpers -- talker
    require_all 'app/helpers/talker/common_actions.rb'
    require_all 'app/helpers/talker/errors.rb'
    require_all 'app/helpers/talker'
    ## helpers -- menus
    require_all 'app/helpers/menus/registration.rb'
    require_all 'app/helpers/menus/main_menu.rb'
    require_all 'app/helpers/menus/schedules.rb'
    require_all 'app/helpers/menus/preferences.rb'
    require_all 'app/helpers/menus'
    ## helpers
    require_all 'app/helpers'
    ## services
    require_all 'app/services'
    ## handlers
    require_all 'app/handlers/base.rb'
    require_all 'app/handlers/*.rb'
    require_all 'app/handlers/callbacks/base.rb'
    require_all 'app/handlers/callbacks'
    require_all 'app/handlers/text_commands'
    ## decorators
    require_all 'app/decorators/base.rb'
    require_all 'app/decorators/preferences/base.rb'
    require_all 'app/decorators/preferences'
    require_all 'app/decorators/schedules/base.rb'
    require_all 'app/decorators/schedules'
    require_all 'app/decorators'
    ## actions
    require_all 'app/actions/base.rb'
    require_all 'app/actions/users/base.rb'
    require_all 'app/actions/users'
    require_all 'app/actions/features/base.rb'
    require_all 'app/actions/features/schedules/base.rb'
    require_all 'app/actions/features/schedules/schedule/schedule.rb'
    require_all 'app/actions/features'
    ## dialogs
    require_all 'app/dialogs'
    ## routers
    require_all 'app/routers/base.rb'
    require_all 'app/routers/features'
    require_all 'app/routers/messages/base.rb'
    require_all 'app/routers/messages/text_commands_router.rb'
    require_all 'app/routers/messages/callbacks_router.rb'
    require_all 'app/routers/messages'
    ## serializers
    require_all 'app/serializers'
    ## constants
    require_all 'app/constants/options_lists.rb'
    require_all 'app/constants'
    ## models
    require_all 'app/models'

    ## global files
    require_all 'app/*.rb'
  end

  task 'load_locales' do
    I18n.load_path << Dir[File.expand_path('lib/locales') + '/*.yml']
    I18n.default_locale = :en
  end

  desc 'Require all files and gems'
  task 'require_everything' do
    rake_app = Rake.application

    rake_app['app:require_gems'].invoke
    rake_app['app:require_files'].invoke
    rake_app['db:connect'].invoke
    rake_app['app:load_locales'].invoke
  end
end
