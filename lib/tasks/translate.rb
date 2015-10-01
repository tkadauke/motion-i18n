def convert(file, namespace, value)
  if value.is_a?(Hash)
    value.each do |key, value|
      convert(file, "#{namespace}.#{key}", value)
    end
  else
    file.puts %{"#{namespace}" = "#{value.to_s}";}
  end
end

def droid_convert(file, namespace, value)
  if value.is_a?(Hash)
    value.each do |key, value|
      convert(file, "#{namespace}.#{key}", value)
    end
  else
    # file.puts %{"#{namespace}" = "#{value.to_s}";}
    encoded_val = value.to_s.gsub("'", "&apos;").gsub('"', "&quot;").encode(:xml => :text)
    encoded_name = namespace.to_s.gsub(" ", "_")
    file.puts %{<string name="#{encoded_name}">#{encoded_val}</string>}
  end
end

def ios_translate
  require 'i18n'

  files = Dir.glob("config/locales/*.yml")

  I18n.load_path.clear
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

def droid_translate
  require 'i18n'

  files = Dir.glob("config/locales/*.yml")

  I18n.load_path.clear
  I18n.load_path << files

  files.each do |locale_file|
    locale = File.basename(locale_file).sub(".yml", "")

    all_translations = I18n.backend.send(:lookup, locale.to_sym, "")
    FileUtils.mkdir_p("resources/values-#{locale}")
    File.open("resources/values-#{locale}/strings.xml", 'w') do |file|
      file.puts '<?xml version ="1.0" encoding ="utf-8"?>'
      file.puts '<resources>'
      all_translations.each do |key, value|
        droid_convert(file, key, value)
      end
      file.puts '</resources>'
    end
  end
  # get rid of annoying warnings
  FileUtils.mkdir_p("resources/values-en")
  FileUtils.cp("resources/values-en/strings.xml", "resources/values/strings.xml")
end

desc "Translate (crossplatform)"
task :translate do
  platform = Motion::Project::App.respond_to?(:template) ? Motion::Project::App.template : :ios
  if platform.to_s.start_with?('ios') or platform.to_s.start_with?('osx')
    ios_translate
  elsif platform.to_s.start_with?('android')
    droid_translate
  end
end

namespace :build do
  task :simulator => :translate
  task :device => :translate
end
