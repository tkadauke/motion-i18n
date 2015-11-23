#!/usr/bin/env rake
$:.unshift("/Library/RubyMotion/lib")

if ENV['android']
  require 'motion/project/template/android'
elsif ENV['osx']
  require 'motion/project/template/osx'
else
  require 'motion/project/template/ios'
end

require './lib/motion-i18n'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'MotionI18n'
end
