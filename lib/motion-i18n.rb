require 'motion-require'
require 'tasks/translate'

Motion::Require.all(Dir.glob(File.expand_path('../motion-i18n/**/*.rb', __FILE__)))
