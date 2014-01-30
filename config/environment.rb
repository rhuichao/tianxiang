# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Myapp::Application.initialize!
Rails.logger = Le.new(ENV.fetch('LOGENTRIES_TOKEN')) if !ENV['LOGENTRIES_TOKEN'].nil?
