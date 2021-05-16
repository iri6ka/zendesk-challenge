# Zendesk Ticket Viewer || CLi application built in Ruby for viewing individual and group Zendesk Tickets

Welcome to Zendesk Software Engineer Intern Challenge page. 

This is a CLi application built in Ruby (version ruby 2.7.1p83) as an attempt to pass the colding challenge while pursuing an internship role at Zendesk, Melbourne.

Documentation will cover information about the application, installation proess and dependencies.

## INSTALLATION & REQUIREMENTS

The program requires the following gems and dependencies:

  *  [terminal-table (3.0.1)](https://github.com/tj/terminal-table)
  *  [tty-prompt (0.23.1)](https://github.com/piotrmurach/tty-prompt)
  *  [dotenv (= 2.7.6)](https://rubygems.org/gems/dotenv/versions/2.1.1)

In order to install the program, please, follow those steps.
1. Cloning the GitHub repository. In order to do so, create a folder on your local computer and then request cloring the repository in the terminal:

``` $ git clone https://github.com/iri6ka/zendesk-challenge.git```

2. Get to the root folder of the challenge 
```$ cd zendesk-challenge ```

3. You need to check the version of Ruby installed on your computer by following this command:
```$ ruby -v```

If Ruby is not installed on your local machine or the version is different to the one used in the program, please, follow official guildelines for Ruby installation (see [Ruby Documentation](https://www.ruby-lang.org/en/documentation/installation/)).

4. This application uses a few gems. In order to be able to run the code in the right way, you need to install gem bundler. 

``` $ gem bundler install```
When Bundler is installed, run a command to install all dependencies.

```$ bundle install```

5. This applicaiton is using an environment file which stores sensitve information. In order to run the application properly, donwload the file (sent by email) and then save it in the root directory of zendesk_challenge folder, while renaming it to .env - this will allow the program to make appropriate requests to the Zendesk API Client.

6. To launch the application, run the following command
```$ ruby bin/index.rb```

Now you are set to go!

## ABOUT THE PROGRAM

This application has been built using an official [Zendesk API Client for Ruby](https://github.com/zendesk/zendesk_api_client_rb).

I decided to use this Ruby Gem as I thought it was a great way to explore not only Zendesk documentation, but also look deeper into inbuilt methods and see if that would make the application building process easier. I must say that the gem is definitely great for using build methods and reducing the amount of code to some extent, on another note I faced some challenges with creation of private methods and classes, as they wouldn't correspond with the inbuilt methods or classes. 

This application definitely got me out of the comfort zone to explore Ruby in a deeper level and it was in general enjoyable process which helped me to improve my Ruby skills even thouth not all the aspects of the requirements have been met.

## REQUIREMENTS (DONE status)

* Connect to the Zendesk API (**DONE**)
* Request all the tickets for your account (**DONE**)
* Display them in a list (**DONE**)
* Display individual ticket details (**DONE**)
* Page through tickets when more than 25 are returned (**DONE**)

***Non-functional requirements***
* Include a README with installation and usage instructions (**DONE**)

* The UI can be browser-based or CLI (see example output below) (**CLI**)

* The amount of data you display in the ticket list view and the single ticket view is up to
you (**DONE**)

* How you format and display the ticket 

* The Ticket Viewer should handle the API being unavailable (*to be completed*). 

* We need to see you write at least a few happy path tests (*to be completed*)

### Pagination
This application allows the user to select the number of the page and look through the existing tickets showing on that page (currently showing 25 tickets per page)

### Individual Tickets

This application shows individual ticket to the user while suggesting a range from the total amount of tickets available for that user 
(using inbuilt method from Zendesk API Client - ```client.tickets.count```)
