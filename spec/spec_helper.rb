require "bundler/setup"
require "elastic_mini_query"

require "timecop"

require "lib/helper"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # config.filter_run focus: true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

t = Time.utc(2019, 7, 14, 18, 30, 0)
Timecop.freeze(t)
