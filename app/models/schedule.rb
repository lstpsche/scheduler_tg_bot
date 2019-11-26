# frozen_string_literal: true

class Schedule < ActiveRecord::Base
  has_many :schedule_users
  has_many :users, through: :schedule_users
  has_many :events, dependent: :destroy

  scope :customed, -> { where(customed: true) }
  scope :not_customed, -> { where(customed: false) }

  def author
    schedule_users.find_by(author: true)&.user
  end

  def decorated
    DecoratedSchedule.find_by(id: id)
  end

  def order_by_time(events)
    events.sort_by { |event| event.time.to_datetime }
  end

  def order_by_weekday(events)
    events.sort_by { |event| Constant::WEEKDAYS.index(event.weekday) }
  end
end

class DecoratedSchedule < Schedule
  def additional_info
    super.presence
  end

  def settings
    Constant.schedule_settings_list.map do |result, setting|
      str_setting = setting.to_s
      result.merge(name: str_setting, button_text: str_setting.capitalize, value: try(setting))
    end
  end

  def title
    I18n.t('layouts.schedule.title',
            schedule_name: name,
            schedule_id: id
          )
  end

  def title_with_add_info
    title + "\n" + additional_info
  end

  def view
    title_with_add_info + "\n" + decorated_events
  end

  private

  def decorated_additional_info
    additional_info + "\n"
  end

  def decorated_events
    events_hashed_by_weekday.inject('') do |text, (weekday, events)|
      text + decorated_weekday(weekday, events)
    end
  end

  def decorated_weekday(weekday, events)
    header_weekday = I18n.t('layouts.schedule.events.weekday', weekday: weekday.capitalize)
    weekday_events = events.map(&:decorated_view).inject(&:+)

    header_weekday + weekday_events + "\n"
  end

  def events_hashed_by_weekday
    order_by_weekday(order_by_time(events)).each_with_object({}) do |event, result|
      weekday = event.weekday
      result[weekday] = (Array.wrap(result[weekday]) << event)
    end
  end
end
