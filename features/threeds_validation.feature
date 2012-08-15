Feature: 3DS Validation
  In order to capture monies from a 3DS-enrolled credit card
  Developers should be able to process their callback postdata against SagePay

  Background:
    Given I configure Pigeon with the hash:
      """
      { vendor: 'flowmedia', mode: :live, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """

  Scenario: Submit a valid 3DS request, checking HTTP post, minimum config
    Given Pigeon is configured to return the threeds_url "http://localhost/3ds"
    And we stub perform_post to expect the url "http://localhost/3ds" and data:
      """
      {
        'MD' => 'aaa45678901234567890123456789012345',
        'PARes' => 'SSBmdWNraW5nIGhhdGUgU2FnZVBheSwgaXQncyBhIHBpbGUgb2Ygc2hpdC4NCg0KV2VsbCBkb25lIGZvciBkZWNvZGluZyB0aGlzLCB5b3UgbXVzdCBoYXZlIGJlZW4gYm9yZWQu'
      }
      """
    When we call threeds_validation with the hash below, it should pass
      """
      {
			  'MD' => 'aaa45678901234567890123456789012345',
        'PARes' => 'SSBmdWNraW5nIGhhdGUgU2FnZVBheSwgaXQncyBhIHBpbGUgb2Ygc2hpdC4NCg0KV2VsbCBkb25lIGZvciBkZWNvZGluZyB0aGlzLCB5b3UgbXVzdCBoYXZlIGJlZW4gYm9yZWQu'
      }
      """

  Scenario: Process a 3DS response
    Given Pigeon is configured to return the threeds_url "http://localhost/3ds"
    And we stub perform_post to return:
      """
      VPSProtocol=2.23
      Status=OK
      StatusDetail=Ok.
      VPSTxId=aaa45678901234567890123456789012345678
      SecurityKey=bbb4567890
      TxAuthNo=93458675498760765897985674598769876
      AVSCV2=ALL MATCH
      AddressResult=NOTCHECKED
      PostCodeResult=NOTCHECKED
      CV2Result=NOTCHECKED
      3DSecureStatus=OK
      CAVV=hf8vjr8ehvfubhvhttrhtr
      """
    When we call threeds_validation with the hash:
      """
      {
			  'MD' => 'aaa45678901234567890123456789012345',
        'PARes' => 'SSBmdWNraW5nIGhhdGUgU2FnZVBheSwgaXQncyBhIHBpbGUgb2Ygc2hpdC4NCg0KV2VsbCBkb25lIGZvciBkZWNvZGluZyB0aGlzLCB5b3UgbXVzdCBoYXZlIGJlZW4gYm9yZWQu'
      }
      """
    Then the response should be successful
    And the response should match the hash:
      """
      {
        'VPSProtocol' => '2.23',
        'Status' => 'OK',
        'StatusDetail' => 'Ok.',
        'VPSTxId' => 'aaa45678901234567890123456789012345678',
        'SecurityKey' => 'bbb4567890',
        'TxAuthNo' => '93458675498760765897985674598769876',
        'AVSCV2' => 'ALL MATCH',
        'AddressResult' => 'NOTCHECKED',
        'PostCodeResult' => 'NOTCHECKED',
        'CV2Result' => 'NOTCHECKED',
        '3DSecureStatus' => 'OK',
        'CAVV' => 'hf8vjr8ehvfubhvhttrhtr'
      }
      """