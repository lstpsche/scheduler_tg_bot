# frozen_string_literal: true

class User < ActiveRecord::Base
  serialize :context, ::Serializers::HashSerializer
  store_accessor :context, :last_message, :replace_last_message, :tapped_message
  has_many :schedule_users
  has_many :schedules, through: :schedule_users

  def empty_context
    {
      'last_message' => {
        'result' => {
          'message_id' => nil
        }
      },
      'replace_last_message' => false,
      'tapped_message' => {
        'message_id' => nil
      }
    }
  end

  def context
    super.empty? ? empty_context : super
  end

  def last_message
    context['last_message']
  end

  def last_message_id
    last_message['result']['message_id']
  end

  def tapped_message
    context['tapped_message'] || empty_context['tapped_message']
  end

  def tapped_message=(msg)
    context['tapped_message'] = msg
  end

  def tapped_message_id
    tapped_message['message_id']
  end

  class << self
    def registered?(id:)
      find_by(id: id).present?
    end
  end
end
