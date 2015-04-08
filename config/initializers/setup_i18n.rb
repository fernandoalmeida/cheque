require 'i18n'

DEFAULT_LOCALE = :en

locales = Dir[File.expand_path('../../locale/*.yml', __FILE__)]
I18n.load_path += locales
I18n.backend.load_translations

I18n.locale = DEFAULT_LOCALE
