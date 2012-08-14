Given /^I configure Pigeon with the hash:$/ do |config|
  Pigeon.configure eval(config)
end

Given /^Pigeon is configured to return the register_url "(.*?)"$/ do |url|
  Pigeon.should_receive(:register_url).and_return(url)
end

Given /^we stub perform_post to expect the url "(.*?)" and data:$/ do |url, data|
  Pigeon::Request.any_instance.should_receive(:perform_post).with(url, eval(data))
end

When /^we call payment_request with the hash below, it should pass$/ do |green|
  Pigeon::Gateway.payment_request eval(green)
end