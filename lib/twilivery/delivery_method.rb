module Twilivery
  class DeliveryMethod
    require 'twilio-ruby'
    require 'phony_rails'

    attr_accessor :settings, :message, :response, :headers

    def initialize(options = {})
      @settings = options
    end

    def deliver!(mail)
      @message = prepare_message_from mail

      if @message[:to].empty?
        raise Twilivery::DeliveryException, {}
      else
        post_sms_message @message
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
      if mail.multipart?
        if mail.text_part
          message[:body] = cleanse_encoding(mail.text_part.body.to_s)
        end
      else
        message[:body] = cleanse_encoding(mail.body.to_s)
      end

      message
    end

    def prepare_recipients recipients
      recipients = [recipients] unless recipients.is_a?(Array)
      recipients.map { |r| convert_to_e164(r) }
    end

    def cleanse_encoding content
      ::JSON.parse({c: content}.to_json)["c"]
    end

    def convert_to_e164 raw_phone
      puts "Raw: #{raw_phone}"
      PhonyRails.normalize_number(
        raw_phone.gsub(/\D/, ''),
        country_code: Twilivery.configuration.default_country_code || 'US')
    end

  end
end
