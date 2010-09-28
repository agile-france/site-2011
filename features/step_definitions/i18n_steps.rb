# captured parameter is evaled, use symbol or nil (:fr, :de, nil)
# example:
# * Given locale is "nil" => set i18n current locale to nil, that is reset locale
# * Given locale is ":en" => set i18n current locale to :de, that is german I believe
Given /locale is "([^"]*)"/ do |locale|
  eval("I18n.locale = #{locale}")
end