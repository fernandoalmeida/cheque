require 'i18n'

locales = Dir[File.expand_path('../../locale/*.yml', __FILE__)]
I18n.load_path += locales
I18n.backend.load_translations
I18n.locale = I18n.default_locale
