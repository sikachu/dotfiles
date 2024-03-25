# print SQL to STDOUT
# if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
#   require 'logger'
#   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
# elsif defined?(Rails) && !Rails.env.nil?
#   if Rails.logger
#     Rails.logger = Logger.new(STDOUT)
#     ActiveRecord::Base.logger = Rails.logger if defined? ActiveRecord
#     Mongoid.logger = Rails.logger if defined? Mongoid
#   end
# end

# Autocomplete
require "irb/completion"

# Set prompt behavior
# ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
# IRB.conf[:PROMPT_MODE] = :DEFAULT
IRB.conf[:USE_MULTILINE] = true

# History
require "irb/ext/save-history" unless RUBY_VERSION > "3.3"
IRB.conf[:SAVE_HISTORY] = 1_000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end
