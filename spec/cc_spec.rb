require 'spec_helper'

describe Twilivery::DeliveryMethod do

  before(:each) do
    @delivery_method = Twilivery::DeliveryMethod.new
  end

  context "CC" do
    it "handles one recipient" do
      test_email = Mailer.test_email(cc: '+18131234567')
      @delivery_method.deliver!(test_email)

      expect(@delivery_method.message[:to]).to include('+18131234567')
    end

    it "handles multiple recipients" do
      test_email = Mailer.test_email(cc: ['+18131234567', '+18131234568'])
      @delivery_method.deliver!(test_email)

      expect(@delivery_method.message[:to]).to include('+18131234567')
      expect(@delivery_method.message[:to]).to include('+18131234568')
    end
  end
end
