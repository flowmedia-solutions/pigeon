Given /^Pigeon is configured to return the refund_url "(.*?)"$/ do |url|
  Pigeon.should_receive(:refund_url).and_return(url)
end

When /^we call refund_request with the hash below, it should pass$/ do |green|
  Pigeon::Gateway.refund_request eval(green)
end

When /^we call refund_request with the hash:$/ do |green|
  @response = Pigeon::Gateway.refund_request eval(green)
end