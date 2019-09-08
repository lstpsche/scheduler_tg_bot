# frozen_string_literal: true

class Context
  class << self
    def init
      init_context_var
      init_return_to_for_users
    end

    def save_return_to_for(user_id:, context:)
      @@context[:return_to][user_id] = context
    end

    def get_return_to_for(user_id:)
      context = @@context[:return_to][user_id]
      if context.nil?
        puts "#{Time.now}: Context.get_return_to_for -- no `return_to` saved for {chat_id: #{chat_id}}. Returned nil."
        context
      else
        context
      end
    end

    def save_last_message_for(user_id:, message:)
      @@context[:message][user_id] = message
    end

    def get_last_message_for(user_id:)
      message = @@context[:message][user_id]
      if message.nil?
        puts "#{Time.now}: Context.get_last_message_for -- no `message` saved for {chat_id: #{chat_id}}. Returned nil."
        message
      else
        message
      end
    end
  end

  private

  def init_context_var
    @@context ||= {}
    @@context[:return_to] ||= {}
    @@context[:message] ||= {}
  end

  def init_return_to_for_users
    User.pluck(:id).each do |user_id|
      @@context[:return_to][user_id] ||= 'main_menu'
    end
  end
end
