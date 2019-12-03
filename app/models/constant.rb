# frozen_string_literal: true

class Constant
  WEEKDAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

  class << self
    include Constants::Regexes
    include Constants::Options
    include Constants::Callbacks

    # using for inner coding. no need to translate
    def text_commands
      [
        '/start',
        '/menu',
        '/help'
      ]
    end

    def translated_weekdays
      weekdays.map do |weekday|
        I18n.t(weekday, scope: 'weekdays')
      end
    end

    def back_button
      Array.wrap(I18n.t('common.buttons.back'))
    end

    private

    def options_translations_for(options, scope)
      # returns hash: { name: '.....', text: '....' }
      options.map do |option|
        I18n.t(option, scope: scope)
      end
    end
  end
end
