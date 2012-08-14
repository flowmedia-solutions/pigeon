Given /^we stub perform_post to return:$/ do |string|
  resp = double('resp')
  resp.stub(:body) { string }
  resp.stub(:code) { 200 }
  Pigeon::Request.any_instance.should_receive(:perform_post).and_return(resp)
end

When /^we call PaymentRequest with the hash:$/ do |green|
  @response = Pigeon::Gateway.payment_request eval(green)
end

Then /^the response should be successful$/ do
  @response.success?.should be_true
end

Then /^the response should not require 3DS$/ do
  @response.requires_threeds?.should be_false
end

Then /^the response should match the hash:$/ do |green|
  @response.to_hash.should eq eval(green)
end