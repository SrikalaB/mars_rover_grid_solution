Dir["../lib/**/*.rb"].each { |f| require_relative f }

RSpec.configure do |config|
  config.color = true
end