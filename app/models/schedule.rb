# frozen_string_literal: true

class Schedule < ActiveRecord::Base
  has_many :schedule_users
  has_many :users, through: :schedule_users
  has_many :events

  scope :customed, -> { where(customed: true) }
  scope :not_customed, -> { where(customed: false) }

  def author
    schedule_users.find_by(author: true)&.user
  end
end
