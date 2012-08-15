Feature: Refund a Transaction
  In order to refund a transaction
  Developers should be able to process their refund request against SagePay

  Background:
    Given I configure Pigeon with the hash:
      """
      { vendor: 'flowmedia', mode: :test, threeds_callback_url: 'http://www.cheeseandbiscuits.com/payment/complete' }
      """

  Scenario: Submit a valid refund request, checking HTTP post, minimum config
    Given Pigeon is configured to return the refund_url "http://localhost/refund"
    And we stub perform_post to expect the url "http://localhost/refund" and data:
      """
      {
        'VPSProtocol' => '2.23',
        'TxType' => 'REFUND',
        'Vendor' => 'flowmedia',
        'VendorTxCode' => 'original-tx',
        'VPSTxId' => 'eee45678901234567890123456789012345678',
        'SecurityKey' => '1234567890',
        'TxAuthNo' => '34876435894850937598357598375'
      }
      """
    When we call refund_request with the hash below, it should pass
      """
      {
        'VendorTxCode' => 'original-tx',
        'VPSTxId' => 'eee45678901234567890123456789012345678',
        'SecurityKey' => '1234567890',
        'TxAuthNo' => '34876435894850937598357598375'
      }
      """

  Scenario: Process a refund response
    Given Pigeon is configured to return the refund_url "http://localhost/refund"
    And we stub perform_post to return:
      """
      VPSProtocol=2.23
      Status=OK
      StatusDetail=Transaction voided.
      """
    When we call refund_request with the hash:
      """
      {
        'VendorTxCode' => 'original-tx',
        'VPSTxId' => 'eee45678901234567890123456789012345678',
        'SecurityKey' => '1234567890',
        'TxAuthNo' => '34876435894850937598357598375'
      }
      """
    Then the response should be successful
    And the response should match the hash:
      """
      {
        'VPSProtocol' => '2.23',
        'Status' => 'OK',
        'StatusDetail' => 'Transaction voided.'
      }
      """