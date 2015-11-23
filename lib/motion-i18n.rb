require 'motion-require'

platform = Motion::Project::App.respond_to?(:template) ? Motion::Project::App.template : :ios
if platform.to_s.start_with?('ios') or platform.to_s.start_with?('osx')
  platform_name = 'ios'
elsif platform.to_s.start_with?('android')
  platform_name = 'android'
end

require "motion-i18n-#{platform_name}/translate"

Motion::Project::App.setup do |app|
  platform_lib = File.join(File.dirname(__FILE__), "motion-i18n-#{platform_name}")
  unless File.exists? platform_lib
    raise "Sorry, the platform #{platform.inspect} (aka #{platform_name}) is not supported by motion-i18n"
  end

  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(platform_lib, 'i18n.rb')).reverse.each do |file|
    app.files.insert(insert_point, file)
  end

end
