def convert(file, namespace, value)
  if value.is_a?(Hash)
    value.each do |key, value|
      convert(file, "#{namespace}.#{key}", value)
    end
  else
    translation = value.to_s.gsub(/(")/) { |character| "\\#{character}"}
    file.puts %{"#{namespace}" = "#{translation}";}
  end
end

desc "Convert YAML translations to Localizable.strings format"
task :translate do
  require 'i18n'

  files = Dir.glob("config/locales/*.yml")

  I18n.load_path << files

  files.each do |locale_file|
    locale = File.basename(locale_file).sub(".yml", "")

    all_translations = I18n.backend.send(:lookup, locale.to_sym, "")
    FileUtils.mkdir_p("resources/#{locale}.lproj")
    File.open("resources/#{locale}.lproj/Localizable.strings", 'w') do |file|
      all_translations.each do |key, value|
        convert(file, key, value)
      end
    end
  end
end

namespace :build do
  task :simulator => :translate
  task :device => :translate
end
