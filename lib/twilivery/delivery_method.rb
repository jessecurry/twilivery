module Twilivery
  class DeliveryMethod
    require 'twilio-ruby'

    attr_accessor :settings, :data, :response, :headers

    def initialize(options = {})
      @settings = options
    end

    def deliver!(mail)
      message = prepare_message_from mail

      if message[:to].empty?
        raise Twilivery::DeliveryException, {}
      else
        post_sms_message message
      end
    end

    ###########################################################################
    private

    def twilio
      @twilio ||= Twilio::REST::Client.new(Twilivery.configuration.account_sid, Twilivery.configuration.auth_token)
    end

    def post_sms_message message
      message[:to].each do |recipient|
        twilio.messages.create(
          from: message[:from],
          to: recipient,
          body: message[:body]
        )
      end
    end

    def prepare_message_from mail
      message = {}

      # Sender
      message[:from] = mail.from.first || Twilivery.configuration.default_sms_sender

      # Recipients
      message[:to] = prepare_recipients(mail.to)
      message[:to] += prepare_recipients(mail.cc).flatten unless mail.cc.nil?
      message[:to] += prepare_recipients(mail.bcc).flatten unless mail.bcc.nil?

      # Body
      if mail.text_part
        message[:body] = cleanse_encoding(mail.text_part.body.to_s)
      end

      message
    end

    def prepare_recipients recipients
      recipients = [recipients] unless recipients.is_a?(Array)
      recipients
    end

    def cleanse_encoding content
      ::JSON.parse({c: content}.to_json)["c"]
    end

  end
end
