require 'hirb'
Hirb::View.enable

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 2000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"


# To show SQL Statements in the rails console
# copy this code to ~/.irbrc
# code found there http://frozenplague.net/2008/12/showing-sql-statements-in-scriptconsole/

if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end
