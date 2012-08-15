Feature: Payment Response
  In order to capture monies from a credit card
  Developers should be able to receive responses from SagePay
  
  Background:
    Given I configure Pigeon with the hash:
      """
      { vendor: 'flowmedia', mode: :test, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
  
  Scenario: Submit a valid payment request, checking HTTP post, minimum config, without 3DS
    Given Pigeon is configured to return the register_url "http://localhost/register"
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
      3DSecureStatus=NOAUTH
      """
    When we call PaymentRequest with the hash:
      """
      {
			  :amount => 1234,
        :card_type => :visa,
        
			  'VendorTxCode' => 'test',
			  'Currency' => 'GBP',
			  'Description' => 'Test Transaction',
			  'CardHolder' => 'Michael Daniels',
			  'CardNumber' => '0000000000000001',
			  'StartDate' => '0111',
			  'ExpiryDate' => '0113',
			  'IssueNumber' => '02',
			  'CV2' => '123',
			  'BillingSurname' => 'Daniels',
			  'BillingFirstnames' => 'Michael',
			  'BillingAddress1' => '1 The Lane',
			  'BillingCity' => 'Portsmouth',
			  'BillingPostCode' => 'PO1 2AP',
			  'BillingCountry' => 'GB',
			  'DeliverySurname' => 'Arkranian',
			  'DeliveryFirstnames' => 'Artur',
			  'DeliveryAddress1' => '7 The Hole',
			  'DeliveryCity' => 'Cambridge',
			  'DeliveryPostCode' => 'CB1 2AS',
			  'DeliveryCountry' => 'GB'
      }
      """
    Then the response should be successful
    And the response should not require 3DS
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
        '3DSecureStatus' => 'NOAUTH'
      }
      """

  Scenario: Submit a valid payment request, checking HTTP post, minimum config, with 3DS
    Given Pigeon is configured to return the register_url "http://localhost/register"
    And we stub perform_post to return:
      """
      VPSProtocol=2.23
      Status=3DAUTH
      StatusDetail=Ok.
      3DSecureStatus=OK
      MD=aaa45678901234567890123456789012345
      ACSURL=http://localhost/bank/acs
      PAReq=SSBmdWNraW5nIGhhdGUgU2FnZVBheSwgaXQncyBhIHBpbGUgb2Ygc2hpdC4NCg0KV2VsbCBkb25lIGZvciBkZWNvZGluZyB0aGlzLCB5b3UgbXVzdCBoYXZlIGJlZW4gYm9yZWQu
      """
    When we call PaymentRequest with the hash:
      """
      {
			  :amount => 1234,
        :card_type => :visa,

			  'VendorTxCode' => 'test',
			  'Currency' => 'GBP',
			  'Description' => 'Test Transaction',
			  'CardHolder' => 'Michael Daniels',
			  'CardNumber' => '0000000000000001',
			  'StartDate' => '0111',
			  'ExpiryDate' => '0113',
			  'IssueNumber' => '02',
			  'CV2' => '123',
			  'BillingSurname' => 'Daniels',
			  'BillingFirstnames' => 'Michael',
			  'BillingAddress1' => '1 The Lane',
			  'BillingCity' => 'Portsmouth',
			  'BillingPostCode' => 'PO1 2AP',
			  'BillingCountry' => 'GB',
			  'DeliverySurname' => 'Arkranian',
			  'DeliveryFirstnames' => 'Artur',
			  'DeliveryAddress1' => '7 The Hole',
			  'DeliveryCity' => 'Cambridge',
			  'DeliveryPostCode' => 'CB1 2AS',
			  'DeliveryCountry' => 'GB'
      }
      """
    Then the response should be successful
    And the response should require 3DS
    And the response should match the hash:
      """
      {
        'VPSProtocol' => '2.23',
        'Status' => '3DAUTH',
        'StatusDetail' => 'Ok.',
        '3DSecureStatus' => 'OK',
        'MD' => 'aaa45678901234567890123456789012345',
        'ACSURL' => 'http://localhost/bank/acs',
        'PAReq' => 'SSBmdWNraW5nIGhhdGUgU2FnZVBheSwgaXQncyBhIHBpbGUgb2Ygc2hpdC4NCg0KV2VsbCBkb25lIGZvciBkZWNvZGluZyB0aGlzLCB5b3UgbXVzdCBoYXZlIGJlZW4gYm9yZWQu'
      }
      """