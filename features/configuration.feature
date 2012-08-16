Feature: Module Configuration
  In order to save repeatedly specifying credentials and callbacks
  Developers should be able to configure the module for use

  Scenario: Configure with valid details
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :live, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then no exceptions should be raised
    And the following hash should be returned:
      """
      {
        vendor: 'flowmedia',
        mode: :live,
        threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete',
        vps_protocol: '2.23',
        simulate_register_url: 'https://test.sagepay.com/Simulator/VSPDirectGateway.asp',
        simulate_threeds_url: 'https://test.sagepay.com/Simulator/VSPDirectCallback.asp',
        simulate_paypal_url: 'https://test.sagepay.com/Simulator/paypalcomplete.asp',
        simulate_void_url: 'https://test.sagepay.com/Simulator/VSPServerGateway.asp?Service=VendorVoidTx',
        simulate_refund_url: 'https://test.sagepay.com/Simulator/VSPServerGateway.asp?Service=VendorRefundTx',
        test_register_url: 'https://live.sagepay.com/gateway/service/vspdirect-register.vsp',
        test_threeds_url: 'https://test.sagepay.com/gateway/service/direct3dcallback.vsp',
        test_paypal_url: 'https://test.sagepay.com/gateway/service/complete.vsp',
        test_void_url: 'https://test.sagepay.com/gateway/service/void.vsp',
        test_refund_url: 'https://test.sagepay.com/gateway/service/refund.vsp',
        live_register_url: 'https://live.sagepay.com/gateway/service/vspdirect-register.vsp',
        live_threeds_url: 'https://live.sagepay.com/gateway/service/direct3dcallback.vsp',
        live_paypal_url: 'https://live.sagepay.com/gateway/service/complete.vsp',
        live_void_url: 'https://live.sagepay.com/gateway/service/void.vsp',
        live_refund_url: 'https://live.sagepay.com/gateway/service/refund.vsp'
      }
      """

  Scenario: Configure without vendor
    When I configure Pigeon with the possibly erroneous hash:
      """
      { mode: :live, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then a ConfigurationException should be raised with the message "You must supply :vendor when configuring Pigeon."

  Scenario: Configure with an incorrect mode
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :break, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then a ConfigurationException should be raised with the message "You must supply a valid :mode when configuring Pigeon."

  Scenario: Configure without threeds_callback_url
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :simulate }
      """
    Then a ConfigurationException should be raised with the message "You must supply :threeds_callback_url when configuring Pigeon."

  Scenario: Check mode methods respect configured mode (default)
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then simulate? should return true
    And test? should return false
    And live? should return false

  Scenario: Check mode methods respect configured mode (simulate)
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :simulate, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then simulate? should return true
    And test? should return false
    And live? should return false

  Scenario: Check mode methods respect configured mode (test)
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :test, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then simulate? should return false
    And test? should return true
    And live? should return false

  Scenario: Check mode methods respect configured mode (live)
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :live, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then simulate? should return false
    And test? should return false
    And live? should return true

  Scenario: Check URL methods respect configured mode (simulate)
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :simulate, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then register_url should return "https://test.sagepay.com/Simulator/VSPDirectGateway.asp"
    And threeds_url should return "https://test.sagepay.com/Simulator/VSPDirectCallback.asp"
    And paypal_url should return "https://test.sagepay.com/Simulator/paypalcomplete.asp"
    And void_url should return "https://test.sagepay.com/Simulator/VSPServerGateway.asp?Service=VendorVoidTx"
    And refund_url should return "https://test.sagepay.com/Simulator/VSPServerGateway.asp?Service=VendorRefundTx"

  Scenario: Check URL methods respect configured mode (test)
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :test, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then register_url should return "https://live.sagepay.com/gateway/service/vspdirect-register.vsp"
    And threeds_url should return "https://test.sagepay.com/gateway/service/direct3dcallback.vsp"
    And paypal_url should return "https://test.sagepay.com/gateway/service/complete.vsp"
    And void_url should return "https://test.sagepay.com/gateway/service/void.vsp"
    And refund_url should return "https://test.sagepay.com/gateway/service/refund.vsp"

  Scenario: Check URL methods respect configured mode (live)
    When I configure Pigeon with the possibly erroneous hash:
      """
      { vendor: 'flowmedia', mode: :live, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
    Then register_url should return "https://live.sagepay.com/gateway/service/vspdirect-register.vsp"
    And threeds_url should return "https://live.sagepay.com/gateway/service/direct3dcallback.vsp"
    And paypal_url should return "https://live.sagepay.com/gateway/service/complete.vsp"
    And void_url should return "https://live.sagepay.com/gateway/service/void.vsp"
    And refund_url should return "https://live.sagepay.com/gateway/service/refund.vsp"