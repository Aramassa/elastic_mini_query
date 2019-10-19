require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :spec do
  namespace :data do
    desc "preparing elastice test data"
    task :prepare do
      require "elastic_mini_query"
      require_relative 'spec/lib/helper'
      require_relative 'spec/seed/users'
    end
  end
end