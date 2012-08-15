Feature: Test against the simulator
  In order to check HTTP requests work
  Testers should be able to run against the SagePay simulator

  Background:
    Given I configure Pigeon with the hash:
      """
      { vendor: 'elastic', mode: :simulate, threeds_callback_url: '' }
      """

  Scenario: Post a valid transaction
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