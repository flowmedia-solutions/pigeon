# Pigeon

This is a simple gem for integrating with the SagePay direct API.  Gooooood evening Madaaaame.  There appears to be a pigeon in your bank account.

## Installation

Add this line to your application's Gemfile:

    gem 'pigeon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pigeon

## Usage

    # require 'rubygems'
    require 'pigeon'
    
    Pigeon.configure(vendor: 'flowmedia', mode: :test, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete')
    Pigeon.test? # => true
    response = Pigeon::Gateway.payment_request(
      :vendor_tx_code => 'test',
      :amount => 1234 # in pence
      # ...
    ) # => PaymentResponse
    puts "We got ourselves some monies!" if response.success?
    
    p response.to_hash

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
