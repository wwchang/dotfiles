# Fuzzytime sublet file
# Created with sur-0.2
configure :fuzzytime do |s| # {{{
  s.interval = 60

  # Locales
  s.locales  = {
    :en => { # {{{
      :numbers => [
        "one", "two", "three", "four", "five", "six",
        "seven", "eight", "nine", "ten", "eleven", "twelve"
      ],
      :text => [
        "%0 o'clock", "five past %0", "ten past %0", "quarter past %0",
        "twenty past %0", "twenty-five past %0", "half past %0",
        "twenty-five to %1", "twenty to %1", "quarter to %1", "ten to %1",
        "five to %1", "%1 o'clock"
      ]
    }, # }}}
    :de => { # {{{
      :numbers => [
        "eins", "zwei", "drei", "vier", "fünf", "sechs",
        "sieben", "acht", "neun", "zehn", "elf", "zwölf"
      ],
      :text => [
        "%0 uhr", "fünf nach %0", "zehn nach %0", "viertel nach %0",
        "zwanzig nach %0", "fünf vor halb %1", "halb %1", "fünf nach halb %1",
        "zwanzig vor %1", "viertel vor %1", "zehn vor %1", "fünf vor %1",
        "%1 uhr"
      ]
    }, # }}}
    :fr => { # {{{
      :numbers => [
        "une heure", "deux heures", "trois heures", "quatre heures",
        "cinq heures", "six heures", "sept heures", "huit heures",
        "neuf heures", "dix heures", "onze heures", "douze heures"
      ],
      :text => [
        "%0", "%0 cinq", "%0 dix", "%0 quart", "%0 vingt",
        "%0 vingt-cinq", "%0 et demie", "%1 moins vingt",
        "%1 moins vingt-cinq", "%1 moins quart", "%1 moins dix",
        "%1 moin cinq", "%1"
      ]
    }, # }}}
    :es => { # {{{
      :numbers => [
        "uno", "dos", "tres", "cuatro", "cinco", "seis",
        "siete", "ocho", "nueve", "diez", "once", "doce"
      ],
      :text => [
        "%0 en punto", "%0 y cinco", "%0 y diez", "%0 y cuarto",
        "%0 y veinte", "%0 y veinticinco", "%0 y media",
        "%1 menos veinticinco", "%1 menos veinte", "%1 menos cuarto",
        "%1 menos diez", "%1 menos cinco", "%1 en punto"
      ]
    } # }}}
  }

  # Select locale
  locale = s.config[:locale]
  locale = locale.to_sym if(locale.is_a?(String))

  if(s.locales.include?(locale))
    s.locale = s.locales[locale]
  else
    s.locale = s.locales[:en]
  end
end # }}}

on :run do |s| # {{{
  hour, minute = Time.now.strftime("%I:%M").split(":").map(&:to_i)

  # Assemble and replace text
  s.data = (s.locale[:text][(minute.to_f / 5).round].gsub(/(%[01]{1})/) { |str|
    case str
      when "%0" then s.locale[:numbers][hour - 1]
      when "%1" then s.locale[:numbers][(12 == hour ? 0 : hour)]
    end
  }).capitalize
end # }}}
