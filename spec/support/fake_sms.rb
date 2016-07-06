# Fake Twilio
class FakeSMS
  Message = Struct.new(:from, :to, :body)

  cattr_accessor :messages
  self.messages = []

  def initialize(_account_sid = ENV['TWILIO_ACCOUNT_SID'], _auth_token = ENV['TWILIO_AUTH_TOKEN'])
  end

  def messages
    self
  end

  def create(from:, to:, body:)
    self.class.messages << Message.new(from: from, to: to, body: body)
  end
end
