require "pigeon/version"
require 'pigeon/gateway'
require 'pigeon/request'
require 'pigeon/transaction_registration_request'
require 'pigeon/payment_request'
#require 'pigeon/refund_request'
require 'pigeon/response'
require 'pigeon/exceptions'

module Pigeon
  # You should call *Pigeon.configure* before you do anything else with the module.
  #
  # You must supply three things at a minimum, +:vendor+ your SagePay Vendor ID, +:mode+ which should be one of:
  # +:simulate+:: Use the SagePay simulator
  # +:test+:: Use the SagePay test system
  # +:live+:: Use the SagePay live servers
  # Plus :threeds_callback_url, the URL for SagePay to post 3DS data to.
  #
  # For PayPal support, you must supply :paypal_callback_url.
  #
  # == Example usage:
  #   Pigeon.configure(vendor: 'flowmedia', mode: :live, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete')
  #   Pigeon.test? # => true
  #   response = Pigeon::Gateway.payment(
  #     :vendor_tx_code => 'test',
  #     :amount => 1234 # in pence
  #     # ...
  #   ) # => {PaymentResponse}
  #   puts "We got ourselves some monies!" if response.success?
  #
  # @param [Hash] user-defined options with which to configure the module.
  # @raise [ConfigurationException] if the +:vendor+, +:mode+ or +:threeds_callback_url+ aren't set.
  # @return [Hash] the current module configuration.
  def self.configure(opts)
    @@config = {
      vps_protocol: '2.23',
      mode: :simulate,
      simulate_register_url: 'https://test.sagepay.com/Simulator/VSPDirectGateway.asp',
      simulate_threeds_url: 'https://test.sagepay.com/Simulator/VSPDirectCallback.asp',
      simulate_paypal_url: 'https://test.sagepay.com/Simulator/paypalcomplete.asp',
      test_register_url: 'https://live.sagepay.com/gateway/service/vspdirect-register.vsp',
      test_threeds_url: 'https://test.sagepay.com/gateway/service/direct3dcallback.vsp',
      test_paypal_url: 'https://test.sagepay.com/gateway/service/complete.vsp',
      live_register_url: 'https://live.sagepay.com/gateway/service/vspdirect-register.vsp',
      live_threeds_url: 'https://live.sagepay.com/gateway/service/direct3dcallback.vsp',
      live_paypal_url: 'https://live.sagepay.com/gateway/service/complete.vsp'
    }.merge(opts)
    raise ConfigurationException, 'You must supply a valid :mode when configuring Pigeon.' unless [:simulate, :test, :live].include? @@config[:mode]
    raise ConfigurationException, 'You must supply :vendor when configuring Pigeon.' unless @@config[:vendor]
    raise ConfigurationException, 'You must supply :threeds_callback_url when configuring Pigeon.' unless @@config[:threeds_callback_url]
    @@config
  end
  
  # Returns the current module configuration.  You should make changes using {Pigeon.configure}
  #
  # @return [Hash] the current module configuration.
  def self.config
    raise ConfigurationException, 'You must call Pigeon.configure before using this module.' unless @@config
    @@config
  end

  # Returns whether the gateway will operate against the SagePay Simulator.
  def self.simulate?
    self.config[:mode] == :simulate
  end
  
  # Returns whether the gateway will operate against the SagePay test system.
  def self.test?
    self.config[:mode] == :test
  end
  
  # Returns whether the gateway will operate against the SagePay live servers.
  def self.live?
    self.config[:mode] == :live
  end
  
  # Returns the URL the gateway will use for transaction registration.
  #
  # @return [String] the URL the gateway will use for transaction registration.
  def self.register_url
    self.config["#{@@config[:mode]}_register_url".to_sym]
  end
  
  # Returns the URL the gateway will use for _SagePay_ 3DS callbacks.
  #
  # @return [String] the URL the gateway will use for _SagePay_ 3DS callbacks.
  def self.threeds_url
    self.config["#{@@config[:mode]}_threeds_url".to_sym]
  end
  
  # Returns the URL the gateway will use for PayPal transaction completion.
  #
  # @return [String] the URL the gateway will use for PayPal transaction completion.
  def self.paypal_url
    self.config["#{@@config[:mode]}_paypal_url".to_sym]
  end
end
