RAILS_ENV=#{RAILS_ENV here}

all:
        mkdir logs
        echo "\n\n\n----------->>> New script launch here <<<---------------\n\n\n" >> logs/main_app.log
        nohup bundle exec ruby app.rb >> logs/main_app.log &
