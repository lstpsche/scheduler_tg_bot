# frozen_string_literal: true

class Schedule < ActiveRecord::Base
  has_many :schedule_users
  has_many :users, through: :schedule_users
  has_many :events
end
