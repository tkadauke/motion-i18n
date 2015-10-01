require 'motion-require'
require 'tasks/translate'

platform = Motion::Project::App.respond_to?(:template) ? Motion::Project::App.template : :ios
if platform.to_s.start_with?('ios') or platform.to_s.start_with?('osx')
  platform = 'ios'
elsif platform.to_s.start_with?('android')
  platform = 'droid'
end

Motion::Require.all(Dir.glob(File.expand_path("../motion-i18n/**/**_#{platform}.rb", __FILE__)))
Motion::Require.all(Dir.glob(File.expand_path('../motion-i18n/**/**.rb', __FILE__)))