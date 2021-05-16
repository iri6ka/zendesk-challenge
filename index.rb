require 'dotenv'
Dotenv.load

require 'terminal-table'
require 'zendesk_api'
require 'tty-prompt'


#configuration settings
client = ZendeskAPI::Client.new do |config|
    # Mandatory (All info taken from zendesk api client github documentation):
    config.url = "https://ikonnova.zendesk.com/api/v2/" # e.g. https://yoursubdomain.zendesk.com/api/v2
    config.username = ENV['DB_USER']  # Basic / Token Authentication
    config.password = ENV['DB_PASS']  # Choose one of the following depending on your authentication choice
    config.retry = true  
    config.raise_error_when_rate_limited = false
  
end

#program start
begin
    system "clear"
    sleep(1.0)
    puts "\n Zendesk Ticket Viewer \n Welcome!"
    sleep(1.0)
    puts "Loading..."
    sleep(1.0)
    system "clear"

    




rescue => exception
    puts "Error: #{e.message}"

else
puts "Press any key to exit"
gets
sleep(1.0)
system "clear" 
puts "Thank you for using Zendesk Ticket Viewer. \n Have a great day!"
exit
end

