require 'i18n'
require 'i18n/backend/fallbacks'
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

I18n.load_path = Dir["locale/*"]
I18n.default_locale = :en
I18n.enforce_available_locales = true
# I18n.locale = ENV["LANG"].split("_").first || :en

# puts I18n.t("ask.name")
# name = gets.chomp
# puts I18n.t("ask.location")
# place = gets.chomp
# puts I18n.t("ask.children")
# childnum = gets.chomp.to_i
# puts I18n.t("ask.thanks")
# puts name, place, childnum

name = "Marcos"
place = "Porto Alegre"
childnum = 2
puts I18n.t("result.lives_in", name: name, place: place) +
" " + I18n.t("result.children", count: childnum)
