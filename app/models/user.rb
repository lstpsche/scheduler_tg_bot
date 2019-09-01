# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :schedule_users
  has_many :schedules, through: :schedule_users
end
