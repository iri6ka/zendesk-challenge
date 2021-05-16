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

