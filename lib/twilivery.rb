require "twilivery/delivery_method"
require "twilivery/exceptions"
require "twilivery/railtie"

module Twilivery
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :account_sid
    attr_accessor :auth_token
    attr_accessor :default_sms_sender

    def initialize
      set_defaults
    end

    def set_defaults
      @account_sid = ENV.fetch('TWILIO_ACCOUNT_SID') { '' }
      @auth_token = ENV.fetch('TWILIO_AUTH_TOKEN') { nil }
      @default_sms_sender = ENV.fetch('TWILIO_SMS_SENDER') { nil }
    end
  end
end
