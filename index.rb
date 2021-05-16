require_relative 'errors'
require_relative 'methods'

require 'dotenv'
Dotenv.load

require 'terminal-table'
require 'zendesk_api'
require 'tty-prompt'

prompt = TTY::Prompt.new

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

    loop do
        puts "Loading..."
        sleep(1.0)
        system "clear"

        if client.tickets = true
            puts "Welcome"
            puts "Number of tickets in the system is: #{client.tickets.count}"
            menu = prompt.select("What would you like to do?", # Main entry menu selection
                [
                { name: 'View all Tickets', value: 1},
                { name: 'View Individual Ticket', value: 2},
                { name: 'Exit the program', value: 3}
                ],
                symbols: {marker: "*"} ) # 
                
            case menu
            when 1 #View all tickets (page 1)
                tickets = client.tickets.page(1).per_page(25)
                    client.tickets.all! do |resource, page_number|
                    # tickets.fetch! 
                    tickets.each do |ticket|  
                        table = Terminal::Table.new do |t|
                            t.add_row [ticket['id'].to_i, ticket['status'].capitalize, ticket['subject'].capitalize]
                            t.style = {:width => 80, :padding_left => 1, :border_left => false, :border_right => false }
                            t.align_column(3, :right)
            
                            t.style = {:padding_left => 3, :border_x => "-", :border_i => "x"}
                        end 
                        puts table   
                    end
                    break
                    end

                sub_menu = prompt.select("What would you like to do?", # Main entry menu selection
                        [
                        { name: 'Select another ticket page', value: 1},
                        { name: 'View Individual Ticket', value: 2},
                        { name: 'Exit the program', value: 3}
                        ],
                        symbols: {marker: "*"} ) # 

                    case sub_menu

                    when 1 # Select another ticket page by number
                        number = prompt.ask("\n\n Type in Page Number you would like to look through. Total number of pages = 9. Select a number between 1 and 9").to_i
                            if number == 0 && number > 9
                                puts "Select a number between 1 and 9"
                                return 
                            else
                                tickets = client.tickets.page(number).per_page(25)
                                client.tickets.all! do |resource, page_number|
                                # tickets.fetch! 
                                    tickets.each do |ticket|  
                                        table = Terminal::Table.new do |t|
                                            t.add_row [ticket['id'].to_i, ticket['status'].capitalize, ticket['subject'].capitalize]
                                            t.style = {:width => 80, :padding_left => 1, :border_left => false, :border_right => false }
                                            t.align_column(3, :right)
                                        end  
                                    puts table 
                                    end
                                    puts "You are on page #{number}"
                                    break
                                end
                            end
                            sub_menu = prompt.select("What would you like to do?", # Main entry menu selection
                                [
                                { name: 'Select another ticket page', value: 1},
                                { name: 'View Individual Ticket', value: 2},
                                { name: 'Exit the program', value: 3}
                                ],
                                symbols: {marker: "*"} ) # 
                    when 2 # select individual ticket
                        number = prompt.ask("Type in Ticket ID Number. Choose a number between 1 and #{client.tickets.count}").to_i
                            ticket_id = number.to_i - 1 
                            if number == 0
                                puts "Number can't be 0"
                            return
                            if number == false || number > client.tickets.count
                                puts "Please, try again. Number is invalid"
                            end
                            else
                                table_ticket = Terminal::Table.new do |t|
                                    t.add_row ["ID", client.tickets[ticket_id].id]
                                    t.add_row ["Subject", client.tickets[ticket_id].subject]
                                    t.add_row ["Status", client.tickets[ticket_id].status]
                                    t.add_row ["Created At", client.tickets[ticket_id].created_at]
                                    t.add_row ["Priority", client.tickets[ticket_id].prioriry]
                                    t.add_row ["Description", client.tickets[ticket_id].description]
                                    t.style = {:padding_left => 3, :border_x => "-", :border_i => "x"}
                                end
                                puts table_ticket
                                break
                            end 
                            sub_menu = prompt.select("What would you like to do?", # Main entry menu selection
                                [
                                { name: 'Select another ticket page', value: 1},
                                { name: 'View Individual Ticket', value: 2},
                                { name: 'Exit the program', value: 3}
                                ],
                                symbols: {marker: "*"} ) # 
                    when 3 #quit the program
                        quit_program
                        break
                    end

                
            when 2 #Select individual ticket
                number = prompt.ask("Type in Ticket ID Number. Choose a number between 1 and #{client.tickets.count}").to_i
                        ticket_id = number.to_i - 1 
                        if number == 0
                            puts "Number can't be 0"
                            return
                        else
                            table_ticket = Terminal::Table.new do |t|
                                t.add_row ["ID", client.tickets[ticket_id].id]
                                t.add_row ["Subject", client.tickets[ticket_id].subject]
                                t.add_row ["Status", client.tickets[ticket_id].status]
                                t.add_row ["Created At", client.tickets[ticket_id].created_at]
                                t.add_row ["Priority", client.tickets[ticket_id].prioriry]
                                t.add_row ["Description", client.tickets[ticket_id].description]
                                t.style = {:padding_left => 3, :border_x => "-", :border_i => "x"}
                            end    
                            puts table_ticket
                            break
                        end
            when 3  #quit the program
                quit_program
                exit
            end

        else
            puts "Press any key to exit"
            gets
            sleep(1.0)
            system "clear" 
            puts "Thank you for using Zendesk Ticket Viewer. \n Have a great day!"
            exit
        end
    end
end