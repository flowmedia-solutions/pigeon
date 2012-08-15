Feature: Payment Request
  In order to capture monies from a credit card
  Developers should be able to submit payment requests to SagePay
  
  Background:
    Given I configure Pigeon with the hash:
      """
      { vendor: 'flowmedia', mode: :test, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """
  
  Scenario: Submit a valid payment request, checking HTTP post, minimum config, without 3DS
    Given Pigeon is configured to return the register_url "http://localhost/register"
    And we stub perform_post to expect the url "http://localhost/register" and data:
      """
      {
        'VPSProtocol' => '2.23',
        'Vendor' => 'flowmedia',
        'TxType' => 'PAYMENT',
			  'VendorTxCode' => 'test',
			  'Amount' => '12.34',
			  'Currency' => 'GBP',
			  'Description' => 'Test Transaction',
			  'CardHolder' => 'Michael Daniels',
			  'CardNumber' => '0000000000000001',
			  'StartDate' => '0111',
			  'ExpiryDate' => '0113',
			  'IssueNumber' => '02',
			  'CV2' => '123',
			  'CardType' => 'VISA',
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
    When we call payment_request with the hash below, it should pass
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