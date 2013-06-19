#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Ants::Application.load_tasks

require 'rspec/core/rake_task'

desc "Run tests"
Spec::Rake::SpecTask.new do |t|
	# t.warning = true
	# t.rcov = true
end