# MotionI18n

Rails-style translations for RubyMotion apps.

This gem allows you to specify your RubyMotion translations as `.yml` files. The translations are automatically converted to Cocoa's native format for translations.

# Installation

```
gem install motion-i18n
```

and in your `Rakefile`:

```ruby
require 'motion-i18n'
```

or using bundler:

```ruby
gem "motion-i18n"
```

# Usage

Put your translations in YAML files in `config/locales/`. For each locale there should be a file named as the locale with the extension `.yml`, e.g. `en.yml`, `de.yml` etc.

## Translations

For a guide on how the translation files should look like, see <http://guides.rubyonrails.org/i18n.html#adding-translations>

To translate a string, use `I18n.translate` or the shortcut `I18n.t` like this:

```ruby
I18n.t("main_screen.title")
```

To substitute variables in the string, specify the substitutions in second a hash argument

```ruby
I18n.t("maps.directions", :from => origin, :to => destination)
```

## Locale

You can get the current locale by calling

```ruby
I18n.locale
```

## Workflow

This gem works perfectly together with the `i18n_tools` gem:

```
gem install i18n_tools
```

or in `Gemfile`;

```ruby
gem "i18n_tools", :require => "i18n_tools/tasks"
```

The gem will give you the tasks `rake translations:missing` which shows untranslated strings as well as `rake translations:unused` which shows strings which are translated but not used in the code. For more information, see [i18n_tools](https://github.com/tkadauke/i18n_tools).

# Warning

For each locale `loc`, this gem overwrites the file `resources/loc.lproj/Localizable.strings` before building. Make sure you don't edit this file. Also, you should add these files to `.gitignore`:

```
Localizable.strings
```

# Forking

Feel free to fork and submit pull requests!
