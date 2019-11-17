# frozen_string_literal: true

namespace :db do
  desc 'Generates model with migration. rake db:generate_model[ModelName] -- ModelName should be in CamelCase.'
  task 'generate_model', :camel_model_name do |_tsk, args|
    Dir.mkdir 'app/models' unless File.exist?('app/models/')

    camel_model_name = args['camel_model_name']
    snake_model_name = camel_model_name.split(/(?=[A-Z])/).map(&:downcase).join('_')

    File.open("app/models/#{snake_model_name}.rb", 'w') do |file|
      file.write("# frozen_string_literal: true\n\n")
      file.write("class #{camel_model_name} < ActiveRecord::Base\n")
      file.write("end\n")
    end

    Rake.application['db:new_migration'].invoke("create_#{camel_model_name}")
  end

  desc 'Destroys model with migration.'
  task 'destroy_model', :camel_model_name do |_tsk, args|
    camel_model_name = args['camel_model_name']
    snake_model_name = camel_model_name.split(/(?=[A-Z])/).map(&:downcase).join('_')

    return unless (model_file_path = Dir.glob("app/models/**/#{snake_model_name}.rb").first).present?
    return unless (migration_file_path = Dir.glob("db/migrate/**/*_create_#{snake_model_name}.rb").first).present?

    File.delete(model_file_path)
    File.delete(migration_file_path)
  end

  desc 'Connects database'
  task :connect do
    require 'dotenv/load'

    if ENV['RAILS_ENV'] == 'production'
      host = ENV['DB_HOST']
      name = ENV['DB_NAME']
      user = ENV['DB_USER']
      pass = ENV['DB_PASS']
    else
      host = ENV['DEV_DB_HOST']
      name = ENV['DEV_DB_NAME'] + '_' + ENV['RAILS_ENV']
      user = ENV['DEV_DB_USER']
      pass = ENV['DEV_DB_PASS']
    end

    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql', host: host, database: name, username: user, password: pass
    )
  end
end
