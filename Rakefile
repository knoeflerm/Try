#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Try::Application.load_tasks

desc "Run Tests"
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/*'
end