require 'spec_helper'

describe Twilivery::DeliveryMethod do

  before(:each) do
    @delivery_method = Twilivery::DeliveryMethod.new
  end

  context "From" do
    it "handles sender" do
      test_email = Mailer.test_email(from: '+18131234567')
      @delivery_method.deliver!(test_email)

      expect(@delivery_method.message[:from]).to eq('+18131234567')
    end
  end
end
