module I18n
  class << self
    def translate(key, substitutions = {})
      pkg_name = RMQ.app.context.getPackageName # please use RMQ for now.
      id = RMQ.app.resources.getIdentifier(key.gsub(" ", "_"), "string", pkg_name)
      str = RMQ.app.resources.getString(id)
      str.tap do |result|
        substitutions.each do |key, value|
          result.gsub!("%{#{key}}", value.to_s)
        end
      end
    end
    alias_method :t, :translate

    def locale
      Java::Util::Locale.getDefault
    end
  end
end
