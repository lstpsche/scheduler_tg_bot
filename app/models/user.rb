# frozen_string_literal: true

class User < ActiveRecord::Base
  serialize :context, ::Serializers::HashSerializer
  store_accessor :context, :last_message, :return_to
  has_many :schedule_users
  has_many :schedules, through: :schedule_users

  def last_message
    context['last_message']
  end

  def return_to
    context['return_to']
  end
end
