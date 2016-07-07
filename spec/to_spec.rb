require 'spec_helper'

describe Twilivery::DeliveryMethod do

  before(:each) do
    @delivery_method = Twilivery::DeliveryMethod.new
  end

  context "To" do
    it "handles one recipient" do
      test_email = Mailer.test_email(to: '+18131234567')
      @delivery_method.deliver!(test_email)

      expect(@delivery_method.message[:to]).to eq(['+18131234567'])
    end

    it "handles multiple recipients" do
      test_email = Mailer.test_email(to: ['+18131234567', '+18131234568'])
      @delivery_method.deliver!(test_email)

      expect(@delivery_method.message[:to]).to eq(['+18131234567', '+18131234568'])
    end
  end
end
