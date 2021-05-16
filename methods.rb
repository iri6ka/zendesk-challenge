require_relative 'methods'
require_relative 'errors'

require 'dotenv'
Dotenv.load

require 'terminal-table'
require 'zendesk_api'
require 'tty-prompt'


def quit_program
    system "clear"
    puts "Thank you for using our Ticket Viewer. See you again soon!"
    exit
end