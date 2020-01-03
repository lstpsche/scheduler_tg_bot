APP_ENV=#{RAILS_ENV here}
LOG_FILE = logs/main_app.log

all:
	mkdir -p logs
	echo "$(tail -1000 logs/main_app.log)" > $(LOG_FILE)
	echo "\n\n\n----------->>> New script launch here <<<---------------\n\n\n" >> $(LOG_FILE)
	RAILS_ENV=$(APP_ENV) nohup bundle exec ruby app.rb >> $(LOG_FILE) &
