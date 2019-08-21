require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/bin/portcall_spec.rb"
  t.rspec_opts = '--format documentation'
end

