module Twilivery
  class Railtie < Rails::Railtie
    initializer "twilivery.add_delivery_method" do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method :twilivery, Twilivery::DeliveryMethod, return_response: true
      end
    end
  end
end
